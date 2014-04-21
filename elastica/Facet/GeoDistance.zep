namespace Elastica\Facet;

/**
 * Implements the Geo Distance facet.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/search/facets/geo-distance-facet.html
 */
class GeoDistance extends AbstractFacet
{
    /**
     * Sets the ranges for the facet all at once.
     * Sample ranges:
     * array (
     * array("to" => 50),
     * array("from" => 20, "to" => 70),
     * array("from" => 70, "to" => 120),
     * array("from" => 150)
     * )
     *
     * @param  array                           ranges Numerical array with range definitions.
     * @return \Elastica\Facet\GeoDistance
     */
    public function setRanges(array ranges) -> <\Elastica\Facet\GeoDistance>
    {
        return this->setParam("ranges", ranges);
    }

    /**
     * Set the relative GeoPoint for the facet.
     *
     * @param  string                          typeField index type and field e.g foo.bar
     * @param  float                           latitude
     * @param  float                           longitude
     * @return \Elastica\Facet\GeoDistance
     */
    public function setGeoPoint(string typeField, float latitude, float longitude) -> <\Elastica\Facet\GeoDistance>
    {
        return this->setParam(typeField, [
            "lat": latitude,
            "lon": longitude
        ]);
    }

    /**
     * Creates the full facet definition, which includes the basic
     * facet definition of the parent.
     *
     * @see \Elastica\Facet\AbstractFacet::toArray()
     * @throws \Elastica\Exception\InvalidException When the right fields haven"t been set.
     * @return array
     */
    public function toArray()
    {
        /**
         * Set the geo_distance in the abstract as param.
         */
        this->_setFacetParam("geo_distance", this->_params);

        return parent::toArray();
    }
}