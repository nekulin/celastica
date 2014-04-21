namespace Elastica\Aggregation;

abstract class AbstractSimpleAggregation extends AbstractAggregation
{
    /**
     * Set the field for this aggregation
     * @param string field the name of the document field on which to perform this aggregation
     * @return AbstractSimpleAggregation
     */
    public function setField(string field) -> <\\Elastica\Aggregation\AbstractSimpleAggregation>
    {
        return this->setParam("field", field);
    }

    /**
     * Set a script for this aggregation
     * @param string|Script script
     * @return AbstractSimpleAggregation
     */
    public function setScript(var script) -> <\\Elastica\Aggregation\AbstractSimpleAggregation>
    {
        if (script instanceof Script) {
            this->setParam("params", script->getParams());
            let script = script->getScript();
        }
        return this->setParam("script", script);
    }
}
