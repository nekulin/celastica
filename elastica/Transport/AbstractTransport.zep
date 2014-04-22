namespace Elastica\Transport;


/**
 * Elastica Abstract Transport object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
abstract class AbstractTransport extends \Elastica\Param
{
    /**
     * @var \Elastica\Connection
     */
    protected _connection;

    /**
     * Construct transport
     *
     * @param \Elastica\Connection connection Connection object
     */
    public function __construct(<\Elastica\Connection> connection = null) -> void
    {
        if connection {
            this->setConnection(connection);
        }
    }

    /**
     * @return \Elastica\Connection Connection object
     */
    public function getConnection() -> <\Elastica\Connection>
    {
        return this->_connection;
    }

    /**
     * @param \Elastica\Connection connection Connection object
     */
    public function setConnection(<\Elastica\Connection> connection)
    {
        let this->_connection = connection;
    }

    /**
    * Executes the transport request
    *
    * @param  \Elastica\Request  request Request object
    * @param  array             params  Hostname, port, path, ...
    * @return \Elastica\Response Response object
    *
    *
    //To be implemented
    abstract public function exec(<\Elastica\Request> request, array params) -> <\Elastica\Response>;


    * Create a transport
    *
    * The transport parameter can be one of the following values:
    *
    * * string: The short name of a transport. For instance "Http", "Memcache" or "Thrift"
    * * object: An already instantiated instance of a transport
    * * array: An array with a "type" key which must be set to one of the two options. All other
    *          keys in the array will be set as parameters in the transport instance
    *
    * @param mixed transport A transport definition
    * @param \Elastica\Connection connection A connection instance
    * @param array params Parameters for the transport class
    * @throws \Elastica\Exception\InvalidException
    * @return AbstractTransport
    */
    public static function create(var transport, <\Elastica\Connection> connection, array params = []) -> <\Elastica\Transport\AbstractTransport>
    {
        var className, key, value, transportParams;

        if typeof transport == "array" && isset transport["type"] {
            let transportParams = transport;
            unset(transportParams["type"]);

            let params = array_replace(params, transportParams);
            let transport = transport["type"];
        }

        if typeof transport == "string" {
            let className = "Elastica\\Transport\\" . transport;

            if !class_exists(className) {
                throw new \Elastica\Exception\InvalidException("Invalid transport");
            }

            let transport = new className;
        }

        if transport instanceof \Elastica\Transport\AbstractTransport {
            transport->setConnection(connection);

            for key, value in params {
                transport->setParam(key, value);
            }
        } else {
            throw new \Elastica\Exception\InvalidException("Invalid transport");
        }

        return transport;
    }
}