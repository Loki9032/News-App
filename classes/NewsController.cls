public class NewsController {
    @AuraEnabled
    public static Map<String, Object> retrieveNews() {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=NewsApi');
        httpRequest.setMethod('GET');

        Map<String, Object> newJsonData = new Map<String, Object>();
        String strResponse = null;
        try {
            Http http = new Http(); 
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                strResponse = httpResponse.getBody();
            } else {
                throw new CalloutException(httpResponse.getBody());
            }

        } catch (Exception ex) {
            throw ex;
        }

        if (!string.isBlank(strResponse)) {
            newJsonData = (Map<String, Object>) JSON.deserializeUntyped(strResponse);
        }
        if (!newJsonData.isEmpty()) {
            return newJsonData;
        } else {
            return null;
        }
    }
}