namespace Elastica\Exception;

/**
 * Response exception
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class ResponseException extends \Elastica\Exception\RuntimeException implements \Elastica\Exception\ExceptionInterface
{
    /**
     * Request
     *
     * @var \Elastica\Request Request object
     */
    protected _request = null;

    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response = null;

    /**
     * Construct Exception
     *
     * @param \Elastica\Request request
     * @param \Elastica\Response response
     */
    public function __construct(<\Elastica\Request> request, <\Elastica\Response> response)
    {
        let this->_request = request;
        let this->_response = response;
        parent::__construct(response->getError());
    }

    /**
     * Returns request object
     *
     * @return \Elastica\Request Request object
     */
    public function getRequest() -> <\Elastica\Request>
    {
        return this->_request;
    }

    /**
     * Returns response object
     *
     * @return \Elastica\Response Response object
     */
    public function getResponse() -> <\Elastica\Response>
    {
        return this->_response;
    }

    /**
     * Returns elasticsearch exception
     *
     * @return ElasticsearchException
     */
    public function getElasticsearchException() -> <\Elastica\Exception\ElasticsearchException>
    {
        var response, transfer, code;

        let response = this->getResponse();
        let transfer = response->getTransferInfo();
        let code     = array_key_exists("http_code", transfer) ? transfer["http_code"] : 0;

        return new \Elastica\Exception\ElasticsearchException(code, response->getError());
    }
}