namespace Elastica\Filter;

/**
 * Geo distance filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/geo-distance-range-filter.html
 */
class GeoDistanceRange extends AbstractGeoDistance
{
    const RANGE_FROM = "from";
    const RANGE_TO = "to";
    const RANGE_LT = "lt";
    const RANGE_LTE = "lte";
    const RANGE_GT = "gt";
    const RANGE_GTE = "gte";

    const RANGE_INCLUDE_LOWER = "include_lower";
    const RANGE_INCLUDE_UPPER = "include_upper";

    /**
     * @var array
     */
    protected _ranges = [];

    /**
     * @param string       key
     * @param array|string location
     * @param array        ranges
     * @internal param string distance
     */
    public function __construct(string key, var location, var ranges = [])
    {
        parent::__construct(key, location);

        if !empty(ranges) {
            this->setRanges(ranges);
        }
    }

    /**
     * @param  array ranges
     * @return \Elastica\Filter\GeoDistanceRange
     */
    public function setRanges(array ranges) -> <\Elastica\Filter\GeoDistanceRange>
    {
        var key, value;
        let this->_ranges = [];

        for key, value in ranges {
            this->setRange(key, value);
        }

        return this;
    }

    /**
     * @param  string                                 key
     * @param  mixed                                  value
     * @return \Elastica\Filter\GeoDistanceRange
     * @throws \Elastica\Exception\InvalidException
     */
    public function setRange(string key, var value) -> <\Elastica\Filter\GeoDistanceRange>
    {
        switch (key) {
            case self::RANGE_TO:
            case self::RANGE_FROM:
            case self::RANGE_GT:
            case self::RANGE_GTE:
            case self::RANGE_LT:
            case self::RANGE_LTE:
                break;
            case self::RANGE_INCLUDE_LOWER:
            case self::RANGE_INCLUDE_UPPER:
                let value = (boolean) value;
                break;
            default:
                throw new \Elastica\Exception\InvalidException("Invalid range parameter given: " . key);
        }
        let this->_ranges[key] = value;

        return this;
    }

    /**
     * @return array
     */
    public function toArray() -> array
    {
        var key, value;
        for key, value in this->_ranges {
            this->setParam(key, value);
        }

        return parent::toArray();
    }
}