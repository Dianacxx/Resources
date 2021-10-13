public with sharing class SingleAgingRequestMock implements HttpCalloutMock {
    protected Integer code;
    protected String status;
    protected String headers;
    protected String bodyAsString;
    // protected Map<String,Object> bodyAsString;

    public SingleAgingRequestMock(Integer code, String status,String headers, String body) {
        this.code = code;
        this.status = status;
        this.headers = headers;
        this.bodyAsString = body;
    }
    
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse resp = new HttpResponse();
       
        resp.setStatusCode(200);
        resp.setStatus('completed');    
        resp.setBody('{"requestId": 78811190,    "serviceInstanceName": "TestOICic",    "integrationName": "Query Aging - Salesforce Reports",    "integrationIdentifier": "QUERY_AGING_SALES_REPORT",    "integrationVersion": "01.00.0000",    "baseURL": "https://TestOICic-aiocmiller.integration.ocp.oraclecloud.com:443/ic",    "invokeBy": "SFDC_Integration",    "query": [        {            "accountNumber": "",            "accountName": "",            "trxType": "",            "trxNumber": "",            "invoiceDateIsBigger": "",            "invoiceDateIsLower": "",            "invoiceDateIsEqual": ""        }], "records": [        {            "accountNumber": "1277",            "accountName": "Lodi Iron Works  Inc.",            "trxType": "Invoice",            "trxNumber": "38578",            "invoiceDate": "2021-09-09T00:00:00.000+00:00",            "dueDate": "2021-10-09T00:00:00.000+00:00",            "dd1To30": 0,            "dd31To60": 0,            "dd61To90": 0,            "ddOver90": 0,            "balanceOverdue": 0,            "current": 1087.5,            "total": 1087.5,            "businessUnitName": "Miller and Company LLC",            "creditLimit": 50000        },        {            "accountNumber": "114002",            "accountName": "Caterpillar Hodges",            "trxType": "Invoice",            "trxNumber": "37592",            "invoiceDate": "2021-08-12T00:00:00.000+00:00",            "dueDate": "2021-10-11T00:00:00.000+00:00",            "dd1To30": 0,            "dd31To60": 0,            "dd61To90": 0,            "ddOver90": 0,            "balanceOverdue": 0,            "current": 15877.5,            "total": 15877.5,            "businessUnitName": "Miller and Company LLC",            "creditLimit": 100000        },        {            "accountNumber": "1547",            "accountName": "Grede LLC",            "trxType": "Invoice",            "trxNumber": "38874",            "invoiceDate": "2021-09-16T00:00:00.000+00:00",            "dueDate": "2021-10-31T00:00:00.000+00:00",            "dd1To30": 0,            "dd31To60": 0,            "dd61To90": 0,            "ddOver90": 0,            "balanceOverdue": 0,            "current": 12388,            "total": 12388,            "businessUnitName": "Miller and Company LLC",            "creditLimit": 250000        },        {            "accountNumber": "1005",            "accountName": "Aarrowcast Inc.",            "trxType": "Invoice",            "trxNumber": "39146",            "invoiceDate": "2021-09-23T00:00:00.000+00:00",            "dueDate": "2021-11-07T00:00:00.000+00:00",            "dd1To30": 0,            "dd31To60": 0,            "dd61To90": 0,            "ddOver90": 0,            "balanceOverdue": 0,            "current": 14769.86,            "total": 14769.86,            "businessUnitName": "Miller and Company LLC",            "creditLimit": 1500000        },        {            "accountNumber": "1454",            "accountName": "The C.A. Lawton Company",            "trxType": "Invoice",            "trxNumber": "36711",            "invoiceDate": "2021-07-21T00:00:00.000+00:00",            "dueDate": "2021-09-19T00:00:00.000+00:00",            "dd1To30": 15602.4,            "dd31To60": 0,            "dd61To90": 0,            "ddOver90": 0,            "balanceOverdue": 15602.4,            "current": 0,            "total": 15602.4,            "businessUnitName": "Miller and Company LLC",            "creditLimit": 250000        }]}');     
        return resp;
    }
}
