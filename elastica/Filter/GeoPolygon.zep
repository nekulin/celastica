namespace Elastica\Filter;

/**
 * Geo polygon filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/geo-polygon-filter.html
 */
class GeoPolygon extends AbstractFilter
{
    /**
     * Key
     *
     * @var string Key
     */
    protected _key = "";

    /**
     * Points making up polygon
     *
     * @var array Points making up polygon
     */
    protected _points = [];

    /**
     * Construct polygon filter
     *
     * @param string key    Key
     * @param array  points Points making up polygon
     */
    public function __construct(string key, array points) -> void
    {
        let this->_key = key;
        let this->_points = points;
    }

    /**
     * Converts filter to array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @return array
     */
    public function toArray() -> array
    {
        var data = [];
        let data["geo_polygon"][this->_key]["points"] = this->_points;
        return data;
    }
}