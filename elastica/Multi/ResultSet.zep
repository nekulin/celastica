namespace Elastica\Multi;

/**
 * Elastica multi search result set
 * List of result sets for each search request
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class ResultSet implements \Iterator, \ArrayAccess, \Countable
{
    /**
     * Result Sets
     *
     * @var array|\Elastica\ResultSet[] Result Sets
     */
    protected _resultSets = [];

    /**
     * Current position
     *
     * @var int Current position
     */
    protected _position = 0;

    /**
     * Response
     *
     * @var \Elastica\Response Response object
     */
    protected _response;

    /**
     * Constructs ResultSet object
     *
     * @param \Elastica\Response       response
     * @param array|\Elastica\Search[] searches
     */
    public function __construct(<\Elastica\Response> response, array searches)
    {
        this->rewind();
        this->_init(response, searches);
    }

    /**
     * @param  \Elastica\Response                   response
     * @param  array|\Elastica\Search[]             searches
     * @throws \Elastica\Exception\InvalidException
     */
    protected function _init(<\Elastica\Response> response, array searches)
    {
        var responseData, responsesData, key, currentSearch, search, query;

        let this->_response = response;
        let responseData = response->getData();

        if isset responseData["responses"] && is_array(responseData["responses"]) {
            reset(searches);
            let responsesData = responseData["responses"];

            for key, responseData in responsesData {
                let currentSearch = each(searches);

                if currentSearch === false {
                    throw new \Elastica\Exception\InvalidException("No result found for search #" . key);
                } else {
                    if !(currentSearch["value"] instanceof BaseSearch) {
                        throw new \Elastica\Exception\InvalidException("Invalid object for search #" . key . " provided. Should be Elastica\Search");
                    }
                }

                let search = currentSearch["value"];
                let query = search->getQuery();

                let response = new \Elastica\Response(responseData);
                let this->_resultSets[currentSearch["key"]] = new \Elastica\ResultSet(response, query);
            }
        }
    }

    /**
     * @return array|\Elastica\ResultSet[]
     */
    public function getResultSets() -> array
    {
        return this->_resultSets;
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
     * There is at least one result set with error
     *
     * @return bool
     */
    public function hasError() -> boolean
    {
        var resultSet, resultsSets;
        let resultsSets = this->getResultSets();

        for resultSet in resultsSets {
            if resultSet->getResponse()->hasError() {
                return true;
            }
        }

        return false;
    }

    /**
     * @return bool|\Elastica\ResultSet
     */
    public function current()
    {
        if this->valid() {
            return this->_resultSets[this->key()];
        } else {
            return false;
        }
    }

    /**
     * @return void
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
        return isset this->_resultSets[this->key()];
    }

    /**
     * @return void
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
        return count(this->_resultSets);
    }

    /**
     * @param  string|int offset
     * @return boolean true on success or false on failure.
     */
    public function offsetExists(var offset) -> boolean
    {
        return isset this->_resultSets[offset];
    }

    /**
     * @param mixed offset
     * @return mixed Can return all value types.
     */
    public function offsetGet(var offset) -> var
    {
        return isset this->_resultSets[offset] ? this->_resultSets[offset] : null;
    }

    /**
     * @param mixed offset
     * @param mixed value
     * @return void
     */
    public function offsetSet(var offset, var value) -> void
    {
        if offset == null {
            let this->_resultSets[] = value;
        } else {
            let this->_resultSets[offset] = value;
        }
    }

    /**
     * @param mixed offset
     * @return void
     */
    public function offsetUnset(var offset) -> void
    {
        unset(this->_resultSets[offset]);
    }
}