namespace Elastica\Facet;

/**
 * Query facet
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/facets/query-facet.html
 */
class Query extends AbstractFacet
{
    /**
     * Set the query for the facet.
     *
     * @param  \Elastica\Query\AbstractQuery query
     * @return \Elastica\Facet\Query
     */
    public function setQuery(<\Elastica\Query\AbstractQuery> query) -> <\Elastica\Facet\Query>
    {
        return this->_setFacetParam("query", query->toArray());
    }
}