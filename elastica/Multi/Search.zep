namespace Elastica\Multi;

/**
 * Elastica multi search
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/multi-search.html
 */
class Search
{
    /**
     * @var array|\Elastica\Search[]
     */
    protected _searches = [];

    /**
     * @var array
     */
    protected _options = [];

    /**
     * @var \Elastica\Client
     */
    protected _client;

    /**
     * Constructs search object
     *
     * @param \Elastica\Client client Client object
     */
    public function __construct(<\Elastica\Client> client) -> void
    {
        this->setClient(client);
    }

    /**
     * @return \Elastica\Client
     */
    public function getClient() -> <\Elastica\Client>
    {
        return this->_client;
    }

    /**
     * @param  \Elastica\Client       client
     * @return \Elastica\Multi\Search
     */
    public function setClient(<\Elastica\Client> client) -> <\Elastica\Multi\Search>
    {
        let this->_client = client;

        return this;
    }

    /**
     * @return \Elastica\Multi\Search
     */
    public function clearSearches() -> <\Elastica\Multi\Search>
    {
        let this->_searches = [];

        return this;
    }

  /**
   * @param  \Elastica\Search search
   * @param  string           key      Optional key
   * @return \Elastica\Multi\Search
   */
    public function addSearch(<\Elastica\Search> search, string key = null) -> <\Elastica\Multi\Search>
    {
        if key {
            let this->_searches[key] = search;
        } else {
            let this->_searches[]     = search;
        }

        return this;
    }

    /**
     * @param  array|\Elastica\Search[] searches
     * @return \Elastica\Multi\Search
     */
    public function addSearches(array searches) -> <\Elastica\Multi\Search>
    {
        var key, search;
        for key, search in searches {
            this->addSearch(search, key);
        }

        return this;
    }

    /**
     * @param  array|\Elastica\Search[] searches
     * @return \Elastica\Multi\Search
     */
    public function setSearches(array searches) -> <\Elastica\Multi\Search>
    {
        this->clearSearches();
        this->addSearches(searches);

        return this;
    }

    /**
     * @return array|\Elastica\Search[]
     */
    public function getSearches() -> array
    {
        return this->_searches;
    }

    /**
     * @param  string                searchType
     * @return \Elastica\Multi\Search
     */
    public function setSearchType(string searchType) -> <\Elastica\Multi\Search>
    {
        let this->_options[\Elastica\Search::OPTION_SEARCH_TYPE] = searchType;

        return this;
    }

    /**
     * @return \Elastica\Multi\ResultSet
     */
    public function search() -> <\Elastica\Multi\ResultSet>
    {
        var data, response;
        let data = this->_getData();

        let response = this->getClient()->request(
            "_msearch",
            \Elastica\Request::POST,
            data,
            this->_options
        );

        return new \Elastica\ResultSet(response, this->getSearches());
    }

    /**
     * @return string
     */
    protected function _getData() -> string
    {
        var data, search, searches;
        let data = "";
        let searches = this->getSearches();

        for search in searches {
            let data .= this->_getSearchData(search);
        }

        return data;
    }

    /**
     * @param  \Elastica\Search search
     * @return string
     */
    protected function _getSearchData(<\Elastica\Search> search) -> string
    {
        var header, query, data;
        let header = this->_getSearchDataHeader(search);
        let header = (empty(header)) ? new \stdClass : header;
        let query = search->getQuery();

        let data = json_encode(header) . "\n";
        let data.= json_encode(query->toArray()) . "\n";

        return data;
    }

    /**
     * @param  \Elastica\Search search
     * @return array
     */
    protected function _getSearchDataHeader(<\Elastica\Search> search) -> array
    {
        var header;
        let header = search->getOptions();

        if search->hasIndices() {
            let header["index"] = search->getIndices();
        }

        if search->hasTypes() {
            let header["types"] = search->getTypes();
        }

        return header;
    }
}