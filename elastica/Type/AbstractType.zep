namespace Elastica\Type;

/**
 * Abstract helper class to implement search indices based on models.
 *
 * This abstract model should help creating search index and a subtype
 * with some easy config entries that are overloaded.
 *
 * The following variables have to be set:
 *    - _indexName
 *    - _typeName
 *
 * The following variables can be set for additional configuration
 *    - _mapping: Value type mapping for the given type
 *    - _indexParams: Parameters for the index
 *
 * @todo Add some settings examples to code
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
abstract class AbstractType implements \Elastica\SearchableInterface
{
    const MAX_DOCS_PER_REQUEST = 1000;

    /**
     * Index name
     *
     * @var string Index name
     */
    protected _indexName = "";

    /**
     * Index name
     *
     * @var string Index name
     */
    protected _typeName = "";

    /**
     * Client
     *
     * @var \Elastica\Client Client object
     */
    protected _client = null;

    /**
     * Index
     *
     * @var \Elastica\Index Index object
     */
    protected _index = null;

    /**
     * Type
     *
     * @var \Elastica\Type Type object
     */
    protected _type = null;

    /**
     * Mapping
     *
     * @var array Mapping
     */
    protected _mapping = [];

    /**
     * Index params
     *
     * @var array Index  params
     */
    protected _indexParams = [];

    /**
     * Source
     *
     * @var boolean Source
     */
    protected _source = true;

    /**
     * Creates index object with client connection
     *
     * Reads index and type name from protected vars _indexName and _typeName.
     * Has to be set in child class
     *
     * @param  \Elastica\Client                     client OPTIONAL Client object
     * @throws \Elastica\Exception\InvalidException
     */
    public function __construct(<\Elastica\Client> client = null) -> void
    {
        if !client {
            let client = new \Elastica\Client();
        }

        if empty this->_indexName {
            throw new \Elastica\Exception\InvalidException("Index name has to be set");
        }

        if empty this->_typeName {
            throw new \Elastica\Exception\InvalidException("Type name has to be set");
        }

        let this->_client = client;
        let this->_index = new \Elastica\Index(this->_client, this->_indexName);
        let this->_type = new \Elastica\Type(this->_index, this->_typeName);
    }

    /**
     * Creates the index and sets the mapping for this type
     *
     * @param bool recreate OPTIONAL Recreates the index if true (default = false)
     */
    public function create(boolean recreate = false)
    {
        var mapping;

        this->getIndex()->create(this->_indexParams, recreate);

        let mapping = new \Elastica\Type\Mapping(this->getType());
        mapping->setProperties(this->_mapping);
        mapping->setSource(["enabled": this->_source]);
        mapping->send();
    }

    /**
     * @param \Elastica\Query query
     * @param array|int options
     * @return \Elastica\Search
     */
    public function createSearch(<\Elastica\Query> query = null, var options = null) -> <\Elastica\Search>
    {
        return this->getType()->createSearch(query, options);
    }

    /**
     * Search on the type
     *
     * @param  string|array|\Elastica\Query query Array with all query data inside or a Elastica\Query object
     * @return \Elastica\ResultSet          ResultSet with all results inside
     * @see \Elastica\SearchableInterface::search
     */
    public function search(var query = "", options = null) -> <\Elastica\ResultSet>
    {
        return this->getType()->search(query, options);
    }

    /**
     * Count docs in the type based on query
     *
     * @param  string|array|\Elastica\Query query Array with all query data inside or a Elastica\Query object
     * @return int                         number of documents matching the query
     * @see \Elastica\SearchableInterface::count
     */
    public function count(var query = "") -> int
    {
        return this->getType()->count(query);
    }

    /**
     * Returns the search index
     *
     * @return \Elastica\Index Index object
     */
    public function getIndex() -> <\Elastica\Index>
    {
        return this->_index;
    }

    /**
     * Returns type object
     *
     * @return \Elastica\Type Type object
     */
    public function getType() -> <\Elastica\Type>
    {
        return this->_type;
    }

    /**
     * Converts given time to format: 1995-12-31T23:59:59Z
     *
     * This is the lucene date format
     *
     * @param  int    date Date input (could be string etc.) -> must be supported by strtotime
     * @return string Converted date string
     */
    public function convertDate(int date) -> string
    {
        return \Elastica\Util::convertDate(date);
    }
}