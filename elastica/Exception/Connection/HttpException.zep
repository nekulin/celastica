namespace Elastica\Exception\Connection;

/**
 * Connection exception
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class HttpException extends \Elastica\Exception\ConnectionException
{
    /**
     * Error code / message
     *
     * @var string Error code / message
     */
    protected _error = 0;

    /**
     * Construct Exception
     *
     * @param string            error    Error
     * @param \Elastica\Request  request
     * @param \Elastica\Response response
     */
    public function __construct(string error, <\Elastica\Request> request = null, <\Elastica\Response> response = null)
    {
        var message;

        let this->_error = error;

        let message = this->getErrorMessage(this->getError());
        parent::__construct(message, request, response);
    }

    /**
     * Returns the error message corresponding to the error code
     * cUrl error code reference can be found here {@link http://curl.haxx.se/libcurl/c/libcurl-errors.html}
     *
     * @param  string error Error code
     * @return string Error message
     */
    public function getErrorMessage(var error)
    {
        switch (error) {
            case "CURLE_UNSUPPORTED_PROTOCOL":
                let error = "Unsupported protocol";
                break;
            case "CURLE_FAILED_INIT":
                let error = "Internal cUrl error?";
                break;
            case "CURLE_URL_MALFORMAT":
                let error = "Malformed URL";
                break;
            case "CURLE_COULDNT_RESOLVE_PROXY":
                let error = "Couldn't resolve proxy";
                break;
            case "CURLE_COULDNT_RESOLVE_HOST":
                let error = "Couldn't resolve host";
                break;
            case "CURLE_COULDNT_CONNECT":
                let error = "Couldn't connect to host, ElasticSearch down?";
                break;
            case 28:
                let error = "Operation timed out";
                break;
            default:
                let error = "Unknown error:" . error;
                break;
        }

        return error;
    }

    /**
     * Return Error code / message
     *
     * @return string Error code / message
     */
    public function getError() -> string
    {
        return this->_error;
    }
}