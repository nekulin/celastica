namespace Elastica\Exception;


/**
 * Connection exception
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class ConnectionException extends \Elastica\Exception\RuntimeException implements \Elastica\Exception\ExceptionInterface
{
    /**
     * Request
     *
     * @var \Elastica\Request Request object
     */
    protected _request;

    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response;

    /**
     * Construct Exception
     *
     * @param string            message    Message
     * @param \Elastica\Request  request
     * @param \Elastica\Response response
     */
    public function __construct(message, <\Elastica\Request> request = null, <\Elastica\Response> response = null)
    {
        let this->_request = request;
        let this->_response = response;

        parent::__construct(message);
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
}