namespace Quasar\Component\Http;

enum HttpStatusCodeEnum: int
{
    //Information
    CONTINUE = 100;
    SWITCHING_PROTOCOL = 101;
    PROCESSING = 102;
    EARLY_HINTS = 103;

    
    //Success
    OK = 200;
    CREATED = 201;
    ACCEPTED = 202;
    NON_AUTHORITATIVE_INFORMATION = 203;
    NO_CONTENT = 204;
    RESET_CONTENT = 205;
    PARTIAL_CONTENT = 206;
    MULTI_STATUS = 207;
    ALREADY_REPORTED = 208;
    CONTENT_DIFFERENT = 210;
    IM_USED = 226;

    //Redirection
    MULTIPLE_CHOICES = 300;
    MOVED_PERMANENTLY = 301;
    FOUND = 302;
    SEE_OTHER = 303;
    NOT_MODIFIED = 304;
    USE_PROXY = 306;
    TEMPORARY_REDIRECT = 307;
    PERMANENT_REDIRECT = 308;
    TOO_MANY_REDIRECTS = 310;

    //Client error
    BAD_REQUEST = 400;
    UNAUTHORIZED = 401;
    PAYMENT_REQUIRED = 402;
    FORBIDDEN = 403;
    NOT_FOUND = 404;
    METHOD_NOT_ALLOWED = 405;
    NOT_ACCEPTABLE = 406;
    PROXY_AUTHENTICATION = 407;
    REQUEST_TIME_OUT = 408;
    CONFLICT = 409;
    GONE = 410;
    LENGTH_REQUIRED = 411;
    PRECONDITION_FAILED = 412;
    REQUEST_ENTITY_TOO_LARGE = 413;
    REQUEST_URI_TOO_LONG = 414;
    UNSUPPORTED_MEDIA_TYPE = 415;
    REQUESTED_RANGE_UNSATISFIABLE = 416;
    EXPECTATION_FAILED = 417;
    I_M_A_TEAPOT = 418;
    BAD_MAPPING_OR_MISDIRECTED_REQUEST = 421;
    LOCKED = 423;
    METHOD_FAILURE = 424;
    UNORDERED_COLLECTION = 425;
    UPGRADE_REQUIRED = 426;
    PRECONDITION_REQUIRED = 428;
    TOO_MANY_REQUESTS = 429;
    REQUEST_HEADER_FIELDS_TOO_LARGE = 431;

    //Server error
    INTERNAL_ERROR = 500;
    NOT_IMPLEMENTED = 501;
    BAD_GATEWAY = 502;
    SERVICE_UNVAILABLE = 503;
    GATEWAY_TIME_OUT = 504;
    
}