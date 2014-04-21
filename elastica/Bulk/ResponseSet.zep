namespace Elastica\Bulk;

class ResponseSet extends \Elastica\Response implements \Iterator, \Countable
{
    /**
     * @var \Elastica\Bulk\Response[]
     */
    protected _bulkResponses = [];

    /**
     * @var int
     */
    protected _position = 0;

    /**
     * @param \Elastica\Response response
     * @param \Elastica\Bulk\Response[] bulkResponses
     */
    public function __construct(<\Elastica\Response> response, array bulkResponses) -> void
    {
        parent::__construct(response->getData());

        let this->_bulkResponses = bulkResponses;
    }

    /**
     * @return \Elastica\Bulk\Response[]
     */
    public function getBulkResponses()
    {
        return this->_bulkResponses;
    }

    /**
     * Returns first found error
     *
     * @return string
     */
    public function getError() -> string
    {
        var error, bulkResponse, bulkResponses;

        let error = "";
        let bulkResponses = this->getBulkResponses();

        for bulkResponse in bulkResponses {
            if bulkResponse->hasError() {
                return bulkResponse->getError();
            }
        }

        return error;
    }

    /**
     * @return bool
     */
    public function isOk() -> boolean
    {
        boolean ret;
        var bulkResponse, bulkResponses;

        let ret = true;
        let bulkResponses = this->getBulkResponses();
        for bulkResponse in bulkResponses {
            if !bulkResponse->isOk() {
                return false;
            }
        }

        return ret;
    }

    /**
     * @return bool
     */
    public function hasError() -> boolean
    {
        boolean ret;
        var bulkResponse, bulkResponses;

        let ret = false;
        let bulkResponses = this->getBulkResponses();

        for bulkResponse in bulkResponses {
            if bulkResponse->hasError() {
                return true;
            }
        }

        return ret;
    }

    /**
     * @return bool|\Elastica\Bulk\Response
     */
    public function current()
    {
        if this->valid() {
            return this->_bulkResponses[this->key()];
        } else {
            return false;
        }
    }

    /**
     *
     */
    public function next() -> void
    {
        let this->_position = this->_position + 1;
    }

    /**
     * @return int
     */
    public function key() -> int
    {
        return this->_position;
    }

    /**
     * @return bool
     */
    public function valid() -> boolean
    {
        return isset(this->_bulkResponses[this->key()]);
    }

    /**
     *
     */
    public function rewind() -> void
    {
        let this->_position = 0;
    }

    /**
     * @return int
     */
    public function count() -> int
    {
        return count(this->_bulkResponses);
    }
}
