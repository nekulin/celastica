namespace Elastica\Facet;

/**
 * Filter facet
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/facets/filter-facet.html
 */
class Filter extends AbstractFacet
{
    /**
     * Set the filter for the facet.
     *
     * @param  \Elastica\Filter\AbstractFilter filter
     * @return \Elastica\Facet\Filter
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Facet\Filter>
    {
        return this->_setFacetParam("filter", filter->toArray());
    }
}