namespace Elastica;

/**
 * Elastica Request object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Request extends Param
{
    const HEAD = "HEAD";
    const POST = "POST";
    const PUT = "PUT";
    const GET = "GET";
    const DELETE = "DELETE";

    /**
     * @var \Elastica\Connection
     */
    protected _connection;

    /**
     * Construct
     *
     * @param string              path       Request path
     * @param string              method     OPTIONAL Request method (use const"s) (default = self::GET)
     * @param array               data       OPTIONAL Data array
     * @param array               query      OPTIONAL Query params
     * @param Connection connection
     * @return \Elastica\Request OPTIONAL Connection object
     */
    public function __construct(string path, var method = self::GET, var data = [], var query = [], <\Elastica\Connection> connection = null)
    {
        this->setPath(path);
        this->setMethod(method);
        this->setData(data);
        this->setQuery(query);

        if connection {
            this->setConnection(connection);
        }
    }

    /**
     * Sets the request method. Use one of the for consts
     *
     * @param  string           method Request method
     * @return \Elastica\Request Current object
     */
    public function setMethod(string method) -> <\Elastica\Request>
    {
        return this->setParam("method", method);
    }

    /**
     * Get request method
     *
     * @return string Request method
     */
    public function getMethod()
    {
        return this->getParam("method");
    }

    /**
     * Sets the request data
     *
     * @param  array            data Request data
     * @return \Elastica\Request
     */
    public function setData(var data) -> <\Elastica\Request>
    {
        return this->setParam("data", data);
    }

    /**
     * Return request data
     *
     * @return array Request data
     */
    public function getData() -> array
    {
        return this->getParam("data");
    }

    /**
     * Sets the request path
     *
     * @param  string           path Request path
     * @return \Elastica\Request Current object
     */
    public function setPath(path) -> <\Elastica\Request>
    {
        return this->setParam("path", path);
    }

    /**
     * Return request path
     *
     * @return string Request path
     */
    public function getPath() -> string
    {
        return this->getParam("path");
    }

    /**
     * Return query params
     *
     * @return array Query params
     */
    public function getQuery() -> array
    {
        return this->getParam("query");
    }

    /**
     * @param  array            query
     * @return \Elastica\Request
     */
    public function setQuery(var query = []) -> <\Elastica\Request>
    {
        return this->setParam("query", query);
    }

    /**
     * @param  \Elastica\Connection connection
     * @return \Elastica\Request
     */
    public function setConnection(<\Elastica\Connection> connection)
    {
        let this->_connection = connection;

        return this;
    }

    /**
     * Return Connection Object
     *
     * @throws Exception\InvalidException
     * @return \Elastica\Connection
     */
    public function getConnection()
    {
        if empty this->_connection {
            throw new \Elastica\Exception\InvalidException("No valid connection object set");
        }

        return this->_connection;
    }

    /**
     * Sends request to server
     *
     * @return \Elastica\Response Response object
     */
    public function send()
    {
        var transport;
        let transport = this->getConnection()->getTransportObject();

        // Refactor: Not full toArray needed in exec?
        return transport->exec(this, this->getConnection()->toArray());
    }

    /**
     * @return array
     */
    public function toArray()
    {
        var data;
        let data = this->getParams();
        if this->_connection {
            let data["connection"] = this->_connection->getParams();
        }
        return data;
    }

    /**
     * Converts request to curl request format
     *
     * @return string
     */
    public function toString()
    {
        return json_encode(this->toArray());
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return this->toString();
    }
}
