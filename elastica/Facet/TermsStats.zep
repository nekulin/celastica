namespace Elastica\Facet;

/**
 * Implements the statistical facet on a per term basis.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/facets/terms-stats-facet.html
 */
class TermsStats extends AbstractFacet
{

    /**
     * Holds the types of ordering which are allowed
     * by ElasticSearch.
     *
     * @var array
     */
    protected _orderTypes = [
        "term",
        "reverse_term",
        "count",
        "reverse_count",
        "total",
        "reverse_total",
        "min",
        "reverse_min",
        "max",
        "reverse_max",
        "mean",
        "reverse_mean"
    ];

    /**
     * Sets the key field for the query.
     *
     * @param  string                         keyField The key field name for the query.
     * @return \Elastica\Facet\TermsStats
     */
    public function setKeyField(string keyField) -> <\Elastica\Facet\TermsStats>
    {
        return this->setParam( "key_field", keyField );
    }

    /**
     * Sets a script to calculate statistical information on a per term basis
     *
     * @param  string                         valueScript The script to do calculations on the statistical values
     * @return \Elastica\Facet\TermsStats
     */
    public function setValueScript(string valueScript) -> <\Elastica\Facet\TermsStats>
    {
        return this->setParam( "value_script", valueScript );
    }

    /**
     * Sets the ordering type for this facet. ElasticSearch
     * internal default is count.
     *
     * @param  string                              type The order type to set use for sorting of the terms.
     * @throws \Elastica\Exception\InvalidException When an invalid order type was set.
     * @return \Elastica\Facet\TermsStats
     */
    public function setOrder(string type) -> <\Elastica\Facet\TermsStats>
    {
        if !in_array(type, this->_orderTypes) {
            throw new \Elastica\Exception\InvalidException("Invalid order type: " . type);
        }

        return this->setParam("order", type);
    }

    /**
     * Sets a field to compute basic statistical results on
     *
     * @param  string                         valueField The field to compute statistical values for
     * @return \Elastica\Facet\TermsStats
     */
    public function setValueField(string valueField) -> <\Elastica\Facet\TermsStats>
    {
        return this->setParam( "value_field", valueField );
    }

    /**
     * Sets the amount of terms to be returned.
     *
     * @param  int                            size The amount of terms to be returned.
     * @return \Elastica\Facet\Terms
     */
    public function setSize(int size) -> <\Elastica\Facet\TermsStats>
    {
        return this->setParam("size", size);
    }

    /**
     * Creates the full facet definition, which includes the basic
     * facet definition of the parent.
     *
     * @see \Elastica\Facet\AbstractFacet::toArray()
     * @return array
     */
    public function toArray() -> array
    {
        this->_setFacetParam( "terms_stats", this->_params );

        return parent::toArray();
    }

}