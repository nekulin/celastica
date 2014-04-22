namespace Elastica\Query;

/**
 * Simple query
 * Pure php array query. Can be used to create any not existing type of query.
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Simple extends AbstractQuery
{
    /**
     * Query
     *
     * @var array Query
     */
    protected _query = [];

    /**
     * Constructs a query based on an array
     *
     * @param array query Query array
     */
    public function __construct(array query) -> void
    {
        this->setQuery(query);
    }

    /**
     * Sets new query array
     *
     * @param  array                     query Query array
     * @return \Elastica\Query\Simple Current object
     */
    public function setQuery(array query) -> <\Elastica\Query\Simple>
    {
        let this->_query = query;

        return this;
    }

    /**
     * Converts query to array
     *
     * @return array Query array
     * @see \Elastica\Query\AbstractQuery::toArray()
     */
    public function toArray() -> array
    {
        return this->_query;
    }
}