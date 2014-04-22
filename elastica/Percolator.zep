namespace Elastica;

/**
 * Percolator class
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/percolate/
 */
class Percolator
{
    /**
     * Index object
     *
     * @var \Elastica\Index
     */
    protected _index = null;

    /**
     * Construct new percolator
     *
     * @param \Elastica\Index index
     */
    public function __construct(<\Elastica\Index> index)
    {
        let this->_index = index;
    }

    /**
     * Registers a percolator query, with optional extra fields to include in the registered query.
     *
     * @param  string name Query name
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query Query to add
     * @param  array fields Extra fields to include in the registered query
     *                                                                      and can be used to filter executed queries.
     * @return \Elastica\Response
     */
    public function registerQuery(string name, var query, var fields = []) -> <\Elastica\Response>
    {
        var path, data;
        let path = this->_index->getName() . "/.percolator/" . "/" . name;
        let query = \Elastica\Query::create(query);

        let data = array_merge(query->toArray(), fields);

        return this->_index->getClient()->request(path, Request::PUT, data);
    }

    /**
     * Removes a percolator query
     * @param  string name query name
     * @return \Elastica\Response
     */
    public function unregisterQuery(string name) -> <\Elastica\Response>
    {
        var path;
        let path = "_percolator/" . this->_index->getName() . "/" . name;

        return this->_index->getClient()->request(path, \Elastica\Request::DELETE);
    }

    /**
     * Match a document to percolator queries
     *
     * @param  \Elastica\Document doc
     * @param  string|\Elastica\Query|\Elastica\Query\AbstractQuery query Query to filter the percolator queries which
     *                                                                     are executed.
     * @param  string type
     * @return array With matching registered queries.
     */
    public function matchDoc(<\Elastica\Document> doc, var query = null, string type = "type") -> array
    {
        var path, data = [], response;

        let path = this->_index->getName() . "/" . type . "/_percolate";
        let data["doc"] = doc->getData();

        // Add query to filter the percolator queries which are executed.
        if query {
            let query = Query::create(query);
            let data["query"] = query->getQuery();
        }

        let response = this->getIndex()->getClient()->request(path, \Elastica\Request::GET, data);
        let data = response->getData();

        if isset data["matches"] {
            return data["matches"];
        }
        return [];
    }

    /**
     * Return index object
     *
     * @return \Elastica\Index
     */
    public function getIndex()
    {
        return this->_index;
    }
}