namespace Elastica\Filter;

/**
 * And Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.kemper@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/and-filter.html
 */
class BoolAnd extends AbstractMulti
{
    /**
     * @return string
     */
    protected function _getBaseName()
    {
        return 'and';
    }
}