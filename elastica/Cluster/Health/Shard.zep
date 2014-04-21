namespace Elastica\Cluster\Health;

/**
 * Wraps status information for a shard.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/api/admin-cluster-health.html
 */
class Shard
{
    /**
     * The shard index/number.
     *
     * @var int
     */
    protected _shardNumber;

    /**
     * The shard health data.
     *
     * @var array
     */
    protected _data;

    /**
     * @param int   shardNumber The shard index/number.
     * @param array data        The shard health data.
     */
    public function __construct(int shardNumber, array data)
    {
        let this->_shardNumber = shardNumber;
        let this->_data = data;
    }

    /**
     * Gets the index/number of this shard.
     *
     * @return int
     */
    public function getShardNumber() -> int
    {
        return this->_shardNumber;
    }

    /**
     * Gets the status of this shard.
     *
     * @return string green, yellow or red.
     */
    public function getStatus() -> string
    {
        return this->_data["status"];
    }

    /**
     * Is the primary active?
     *
     * @return bool
     */
    public function isPrimaryActive() -> boolean
    {
        return this->_data["primary_active"];
    }

    /**
     * Is this shard active?
     *
     * @return bool
     */
    public function isActive() -> boolean
    {
        return this->_data["active_shards"] == 1;
    }

    /**
     * Is this shard relocating?
     *
     * @return bool
     */
    public function isRelocating() -> boolean
    {
        return this->_data["relocating_shards"] == 1;
    }

    /**
     * Is this shard initialized?
     *
     * @return bool
     */
    public function isInitialized() -> boolean
    {
        return this->_data["initializing_shards"] == 1;
    }

    /**
     * Is this shard unassigned?
     *
     * @return bool
     */
    public function isUnassigned() -> boolean
    {
        return this->_data["unassigned_shards"] == 1;
    }
}
