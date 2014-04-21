namespace Elastica\Filter;

/**
 * Geo distance filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/geo-distance-filter.html
 */
abstract class AbstractGeoDistance extends AbstractFilter
{

    const LOCATION_TYPE_GEOHASH = "geohash";
    const LOCATION_TYPE_LATLON = "latlon";

    /**
     * Location type
     *
     * Decides if this filter uses latitude/longitude or geohash for the location.
     * Values are "latlon" or "geohash".
     *
     * @var string
     */
    protected _locationType = null;

    /**
     * Key
     *
     * @var string
     */
    protected _key = null;

    /**
     * Latitude
     *
     * @var float
     */
    protected _latitude = null;

    /**
     * Longitude
     *
     * @var float
     */
    protected _longitude = null;

    /**
     * Geohash
     *
     * @var string
     */
    protected _geohash = null;

    /**
     * Create GeoDistance object
     *
     * @param  string                              key      Key
     * @param  array|string                        location Location as array or geohash: array("lat" => 48.86, "lon" => 2.35) OR "drm3btev3e86"
     * @internal param string distance Distance
     */
    public function __construct(string key, var location)
    {
        // Key
        this->setKey(key);
        this->setLocation(location);
    }

    /**
     * @param  string                                    key
     * @return \Elastica\Filter\AbstractGeoDistance current filter
     */
    public function setKey(string key) -> <\Elastica\Filter\AbstractGeoDistance>
    {
        let this->_key = key;

        return this;
    }

    /**
     * @param  array|string                              location
     * @return \Elastica\Filter\AbstractGeoDistance
     * @throws \Elastica\Exception\InvalidException
     */
    public function setLocation(location) -> <\Elastica\Filter\AbstractGeoDistance>
    {
        // Location
        if typeof location == "array" { // Latitude/Longitude
            // Latitude
            if isset location["lat"] {
                this->setLatitude(location["lat"]);
            } else {
                throw new \Elastica\Exception\InvalidException("location[\"lat\"] has to be set");
            }

            // Longitude
            if isset location["lon"] {
                this->setLongitude(location["lon"]);
            } else {
                throw new \Elastica\Exception\InvalidException("location[\"lon\"] has to be set");
            }
        } else {
            if typeof location == "string" { // Geohash
                this->setGeohash(location);
            } else { // Invalid location
                throw new \Elastica\Exception\InvalidException("location has to be an array (latitude/longitude) or a string (geohash)");
            }
        }
        return this;
    }

    /**
     * @param  float                                     latitude
     * @return \Elastica\Filter\AbstractGeoDistance current filter
     */
    public function setLatitude(latitude) -> <\Elastica\Filter\AbstractGeoDistance>
    {
        let this->_latitude = (float) latitude;
        let this->_locationType = self::LOCATION_TYPE_LATLON;

        return this;
    }

    /**
     * @param  float                                     longitude
     * @return \Elastica\Filter\AbstractGeoDistance current filter
     */
    public function setLongitude(longitude) -> <\Elastica\Filter\AbstractGeoDistance>
    {
        let this->_longitude = (float) longitude;
        let this->_locationType = self::LOCATION_TYPE_LATLON;

        return this;
    }

    /**
     * @param  string                                    geohash
     * @return \Elastica\Filter\AbstractGeoDistance current filter
     */
    public function setGeohash(geohash) -> <\Elastica\Filter\AbstractGeoDistance>
    {
        let this->_geohash = geohash;
        let this->_locationType = self::LOCATION_TYPE_GEOHASH;

        return this;
    }

    /**
     * @return array|string
     * @throws \Elastica\Exception\InvalidException
     */
    protected function _getLocationData() -> <\Elastica\Exception\InvalidException>
    {
        var location;

        if this->_locationType === self::LOCATION_TYPE_LATLON { // Latitude/longitude
            let location = [];

            if isset this->_latitude { // Latitude
                let location["lat"] = this->_latitude;
            } else {
                throw new \Elastica\Exception\InvalidException("Latitude has to be set");
            }

            if isset this->_longitude { // Geohash
                let location["lon"] = this->_longitude;
            } else {
                throw new \Elastica\Exception\InvalidException("Longitude has to be set");
            }
        } else {
            if this->_locationType === self::LOCATION_TYPE_GEOHASH { // Geohash
                let location = this->_geohash;
            } else { // Invalid location type
                throw new \Elastica\Exception\InvalidException("Invalid location type");
            }
        }

        return location;
    }

    /**
     * @see \Elastica\Param::toArray()
     * @throws \Elastica\Exception\InvalidException
     */
    public function toArray()
    {
        this->setParam(this->_key, this->_getLocationData());
        return parent::toArray();
    }
}