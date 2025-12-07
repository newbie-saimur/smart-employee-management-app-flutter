import 'dart:convert';
import 'package:http/http.dart' as http;

const String GEMINI_API_KEY = "AIzaSyBr9_rxEWyNBiuwqfKQvZeTOr_FtrXKlsI";
const String API_URL =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent";

class GeminiService {
  // Sending prompt to the Gemini API and getting a response
  Future<String> getAiResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$API_URL?key=$GEMINI_API_KEY'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
          // This part will give directions what this AI should do and its responsibility
          "systemInstruction": {
            "parts": [
              {
                "text":
                    "Act as a helpful and professional HR assistant for a corporate company. Answer questions based on the provided policies (or general knowledge if no policy is given). Keep answers concise and professional.",
              },
            ],
          },
          // Google Search Grounding (Optional)
          "tools": [
            {"google_search": {}},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Generated text and grounding sources finding
        final text = data['candidates'][0]['content']['parts'][0]['text'];

        // Adding Grounding source (eg. HR Policy Manual) if available
        final groundingMetadata = data['candidates'][0]['groundingMetadata'];
        String sourceInfo = "";

        if (groundingMetadata != null &&
            groundingMetadata['groundingAttributions'] != null) {
          sourceInfo = "\n\nSource: Company Policy Document";
        }

        return text + sourceInfo;
      } else {
        // API Error Handling
        return "ERROR: API Call failed with status code ${response.statusCode}. Please check your API Key or connection.";
      }
    } catch (e) {
      // Network/Exception Error Handling
      return "ERROR: An error occurred: $e";
    }
  }
}
