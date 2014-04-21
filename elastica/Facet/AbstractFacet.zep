namespace Elastica\Facet;

/**
 * Abstract facet object. Should be extended by all facet types
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
abstract class AbstractFacet extends \Elastica\Param
{
    /**
     * Holds the name of the facet.
     * @var string
     */
    protected _name = "";

    /**
     * Holds all facet parameters.
     * @var array
     */
    protected _facet = [];

    /**
     * Constructs a Facet object.
     *
     * @param string name The name of the facet.
     */
    public function __construct(string name)
    {
        this->setName(name);
    }

    /**
     * Sets the name of the facet. It is automatically set by
     * the constructor.
     *
     * @param  string                              name The name of the facet.
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Facet\AbstractFacet
     */
    public function setName(string name) -> <\Elastica\Facet\AbstractFacet>
    {
        if empty name {
            throw new \Elastica\Exception\InvalidException("Facet name has to be set");
        }
        let this->_name = name;

        return this;
    }

    /**
     * Gets the name of the facet.
     *
     * @return string
     */
    public function getName() -> string
    {
        return this->_name;
    }

    /**
     * Sets a filter for this facet.
     *
     * @param  \Elastica\Filter\AbstractFilter filter A filter to apply on the facet.
     * @return \Elastica\Facet\AbstractFacet
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Facet\AbstractFacet>
    {
        return this->_setFacetParam("facet_filter", filter->toArray());
    }

    /**
     * Sets the flag to either run the facet globally or bound to the
     * current search query. When not set, it defaults to the
     * ElasticSearch default value.
     *
     * @param  bool                         global Flag to either run the facet globally.
     * @return \Elastica\Facet\AbstractFacet
     */
    public function setGlobal(boolean global = true) -> <\Elastica\Facet\AbstractFacet>
    {
        return this->_setFacetParam("global", global);
    }

    /**
     * Sets the path to the nested document
     *
     * @param  string                       nestedPath Nested path
     * @return \Elastica\Facet\AbstractFacet
     */
    public function setNested(string nestedPath) -> <\Elastica\Facet\AbstractFacet>
    {
        return this->_setFacetParam("nested", nestedPath);
    }

    /**
     * Sets the scope
     *
     * @param  string                       scope Scope
     * @return \Elastica\Facet\AbstractFacet
     */
    public function setScope(string scope) -> <\Elastica\Facet\AbstractFacet>
    {
        return this->_setFacetParam("scope", scope);
    }

    /**
     * Basic definition of all specs of the facet. Each implementation
     * should override this function in order to set it"s specific
     * settings.
     *
     * @return array
     */
    public function toArray() -> array
    {
        return this->_facet;
    }

    /**
     * Sets a param for the facet. Each facet implementation needs to take
     * care of handling their own params.
     *
     * @param  string                       key   The key of the param to set.
     * @param  mixed                        value The value of the param.
     * @return \Elastica\Facet\AbstractFacet
     */
    protected function _setFacetParam(string key, var value) -> <\Elastica\Facet\AbstractFacet>
    {
        let this->_facet[key] = value;

        return this;
    }
}