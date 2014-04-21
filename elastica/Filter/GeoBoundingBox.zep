namespace Elastica\Filter;

/**
 * Geo bounding box filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/geo-bounding-box-filter.html
 */
class GeoBoundingBox extends AbstractFilter
{
    /**
     * Construct BoundingBoxFilter
     *
     * @param string key         Key
     * @param array  coordinates Array with top left coordinate as first and bottom right coordinate as second element
     */
    public function __construct(string key, array coordinates) -> void
    {
        this->addCoordinates(key, coordinates);
    }

    /**
     * Add coordinates
     *
     * @param  string                               key         Key
     * @param  array                                coordinates Array with top left coordinate as first and bottom right coordinate as second element
     * @throws \Elastica\Exception\InvalidException  If coordinates doesn"t have two elements
     * @return \Elastica\Filter\GeoBoundingBox Current object
     */
    public function addCoordinates(string key, var coordinates) -> <\Elastica\Filter\GeoBoundingBox>
    {
        if !(isset(coordinates[0]) && isset(coordinates[1])) {
            throw new \Elastica\Exception\InvalidException("expected coordinates to be an array with two elements");
        }

        this->setParam(key, [
            "top_left": coordinates[0],
            "bottom_right": coordinates[1]
        ]);

        return this;
    }
}