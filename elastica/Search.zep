namespace Elastica;

/**
 * Elastica search object
 *
 * @package  Elastica
 * @author   Aris Kemper <aris.github@gmail.com>
 */
class Search
{
    /*
     * Options
     */
    const OPTION_SEARCH_TYPE = "search_type";
    const OPTION_ROUTING = "routing";
    const OPTION_PREFERENCE = "preference";
    const OPTION_VERSION = "version";
    const OPTION_TIMEOUT = "timeout";
    const OPTION_FROM = "from";
    const OPTION_SIZE = "size";
    const OPTION_SCROLL = "scroll";
    const OPTION_SCROLL_ID = "scroll_id";

    /*
     * Search types
     */
    const OPTION_SEARCH_TYPE_COUNT = "count";
    const OPTION_SEARCH_TYPE_SCAN = "scan";
    const OPTION_SEARCH_TYPE_DFS_QUERY_THEN_FETCH = "dfs_query_then_fetch";
    const OPTION_SEARCH_TYPE_DFS_QUERY_AND_FETCH = "dfs_query_and_fetch";
    const OPTION_SEARCH_TYPE_QUERY_THEN_FETCH = "query_then_fetch";
    const OPTION_SEARCH_TYPE_QUERY_AND_FETCH = "query_and_fetch";
    const OPTION_SEARCH_TYPE_SUGGEST = "suggest";

    /**
     * Array of indices
     *
     * @var array
     */
    protected _indices = [];

    /**
     * Array of types
     *
     * @var array
     */
    protected _types = [];

    /**
     * @var \Elastica\Query
     */
    protected _query;

    /**
     * @var array
     */
    protected _options = [];

    /**
     * Client object
     *
     * @var \Elastica\Client
     */
    protected _client;

    /**
     * Constructs search object
     *
     * @param \Elastica\Client client Client object
     */
    public function __construct(<\Elastica\Client> client)
    {
        let this->_client = client;
    }

    /**
     * Adds a index to the list
     *
     * @param  \Elastica\Index|string index Index object or string
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Search                     Current object
     */
    public function addIndex(var index) -> <\Elastica\Search>
    {
        if index instanceof \Elastica\Index {
            let index = index->getName();
        }

        if typeof index != "string" {
            throw new \Elastica\Exception\InvalidException("Invalid param type");
        }

        let this->_indices[] = index;

        return this;
    }

    /**
     * Add array of indices at once
     *
     * @param  array indices
     * @return \Elastica\Search
     */
    public function addIndices(var indices = []) -> <\Elastica\Search>
    {
        var index;

        for index in indices {
            this->addIndex(index);
        }

        return this;
    }

    /**
     * Adds a type to the current search
     *
     * @param  \Elastica\Type|string type Type name or object
     * @return \Elastica\Search                     Search object
     * @throws \Elastica\Exception\InvalidException
     */
    public function addType(var type) -> <\Elastica\Search>
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        }

        if typeof type != "string" {
            throw new \Elastica\Exception\InvalidException("Invalid type type");
        }

        let this->_types[] = type;

        return this;
    }

    /**
     * Add array of types
     *
     * @param  array types
     * @return \Elastica\Search
     */
    public function addTypes(var types = [])
    {
        var type;

        for type in types {
            this->addType(type);
        }
        return this;
    }

    /**
     * @param  string|array|\Elastica\Query|\Elastica\Suggest|\Elastica\Query\AbstractQuery|\Elastica\Filter\AbstractFilter query|
     * @return \Elastica\Search
     */
    public function setQuery(var query)
    {
        let this->_query = \Elastica\Query::create(query);

        return this;
    }

    /**
     * @param  string key
     * @param  mixed value
     * @return \Elastica\Search
     */
    public function setOption(string key, var value) -> <\Elastica\Search>
    {
        this->_validateOption(key);

        let this->_options[key] = value;

        return this;
    }

    /**
     * @param  array options
     * @return \Elastica\Search
     */
    public function setOptions(var options) -> <\Elastica\Search>
    {
        var key, value;

        this->clearOptions();

        for key, value in options {
            this->setOption(key, value);
        }

        return this;
    }

    /**
     * @return \Elastica\Search
     */
    public function clearOptions() -> <\Elastica\Search>
    {
        let this->_options = [];

        return this;
    }

    /**
     * @param  string key
     * @param  mixed value
     * @return \Elastica\Search
     */
    public function addOption(string key, var value) -> <\Elastica\Search>
    {
        this->_validateOption(key);

        if !isset this->_options[key] {
            let this->_options[key] = [];
        }

        //todo
        //let this->_options[key][] = value;

        return this;
    }

    /**
     * @param  string key
     * @return bool
     */
    public function hasOption(key) -> boolean
    {
        return isset this->_options[key];
    }

    /**
     * @param  string key
     * @return mixed
     * @throws \Elastica\Exception\InvalidException
     */
    public function getOption(key)
    {
        if !this->hasOption(key) {
            throw new \Elastica\Exception\InvalidException("Option" . key . " does not exist");
        }

        return this->_options[key];
    }

    /**
     * @return array
     */
    public function getOptions() -> array
    {
        return this->_options;
    }

    /**
     * @param  string key
     * @return bool
     * @throws \Elastica\Exception\InvalidException
     */
    protected function _validateOption(string key) -> boolean
    {
        switch (key) {
            case self::OPTION_SEARCH_TYPE:
            case self::OPTION_ROUTING:
            case self::OPTION_PREFERENCE:
            case self::OPTION_VERSION:
            case self::OPTION_TIMEOUT:
            case self::OPTION_FROM:
            case self::OPTION_SIZE:
            case self::OPTION_SCROLL:
            case self::OPTION_SCROLL_ID:
            case self::OPTION_SEARCH_TYPE_SUGGEST:
                return true;
        }

        throw new \Elastica\Exception\InvalidException("Invalid option " . key);
    }

    /**
     * Return client object
     *
     * @return \Elastica\Client Client object
     */
    public function getClient() -> <\Elastica\Client>
    {
        return this->_client;
    }

    /**
     * Return array of indices
     *
     * @return array List of index names
     */
    public function getIndices() -> array
    {
        return this->_indices;
    }

    /**
     * @return bool
     */
    public function hasIndices() -> boolean
    {
        return count(this->_indices) > 0;
    }

    /**
     * @param Index|string index
     * @return bool
     */
    public function hasIndex(var index) -> boolean
    {
        if index instanceof \Elastica\Index {
            let index = index->getName();
        }

        return in_array(index, this->_indices);
    }

    /**
     * Return array of types
     *
     * @return array List of types
     */
    public function getTypes() -> array
    {
        return this->_types;
    }

    /**
     * @return bool
     */
    public function hasTypes() -> boolean
    {
        return count(this->_types) > 0;
    }

    /**
     * @param \Elastica\Type|string type
     * @return bool
     */
    public function hasType(var type) -> boolean
    {
        if type instanceof \Elastica\Type {
            let type = type->getName();
        }

        return in_array(type, this->_types);
    }

    /**
     * @return \Elastica\Query
     */
    public function getQuery() -> <\Elastica\Query>
    {
        if null === this->_query {
            let this->_query = \Elastica\Query::create("");
        }

        return this->_query;
    }

    /**
     * Creates new search object
     *
     * @param  \Elastica\SearchableInterface searchObject
     * @return \Elastica\Search
     */
    public static function create(<\Elastica\SearchableInterface> searchObject) -> <\Elastica\Search>
    {
        return searchObject->createSearch();
    }

    /**
     * Combines indices and types to the search request path
     *
     * @return string Search path
     */
    public function getPath() -> string
    {
        var indices, types, path = "";

        if isset this->_options[self::OPTION_SCROLL_ID] {
            return "_search/scroll";
        }

        let indices = this->getIndices();
        let types = this->getTypes();

        if empty indices {
            if !empty types {
                let path .= "_all";
            }
        } else {
            let path .= implode(",", indices);
        }

        if !empty types {
            let path .= "/" . implode(",", types);
        }

        // Add full path based on indices and types -> could be all
        return path . "/_search";
    }

    /**
     * Search in the set indices, types
     *
     * @param  mixed query
     * @param  int|array options OPTIONAL Limit or associative array of options (option=>value)
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\ResultSet
     */
    public function search(var query = "", var options = null) -> <\Elastica\ResultSet>
    {
        var path, params, data, response;

        this->setOptionsAndQuery(options, query);

        let query = this->getQuery();
        let path = this->getPath();
        let params = this->getOptions();

        // Send scroll_id via raw HTTP body to handle cases of very large (> 4kb) ids.
        if  path == "_search/scroll" {
            let data = params[self::OPTION_SCROLL_ID];
            unset(params[self::OPTION_SCROLL_ID]);
        } else {
            let data = query->toArray();
        }

        let response = this->getClient()->request(
            path,
            \Elastica\Request::GET,
            data,
            params
        );

        return new \Elastica\ResultSet(response, query);
    }

    /**
     *
     * @param mixed query
     * @param fullResult (default = false) By default only the total hit count is returned. If set to true, the full ResultSet including facets is returned.
     * @return int|ResultSet
     */
    public function count(query = "", fullResult = false)
    {
        var path, arr = [], response, resultSet;

        this->setOptionsAndQuery(null, query);

        let query = this->getQuery();
        let path = this->getPath();

        let arr[self::OPTION_SEARCH_TYPE] =  self::OPTION_SEARCH_TYPE_COUNT;
        let response = this->getClient()->request(
            path,
            \Elastica\Request::GET,
            query->toArray(),
            arr
        );
        let resultSet = new \Elastica\ResultSet(response, query);

        return fullResult ? resultSet : resultSet->getTotalHits();
    }

    /**
     * @param  array|int options
     * @param  string|array|\Elastica\Query query
     * @return \Elastica\Search
     */
    public function setOptionsAndQuery(options = null, query = "") -> <\Elastica\Search>
    {
        if query != "" {
            this->setQuery(query);
        }

        if typeof options == "integer" {
            this->getQuery()->setSize(options);
        } else {
            if typeof options == "array" {
                if isset options["limit"] {
                    this->getQuery()->setSize(options["limit"]);
                    unset(options["limit"]);
                }
                if isset options["explain"] {
                    this->getQuery()->setExplain(options["explain"]);
                    unset(options["explain"]);
                }
                this->setOptions(options);
            }
        }
        return this;
    }

    /**
     * @param Suggest suggest
     * @return Search
     */
    public function setSuggest(<\Elastica\Suggest> suggest) -> <\Elastica\Search>
    {
        var arr = [];
        let arr[self::OPTION_SEARCH_TYPE_SUGGEST] = "suggest";
        return this->setOptionsAndQuery(arr, suggest);
    }
}
