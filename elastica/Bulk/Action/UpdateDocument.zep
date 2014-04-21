namespace Elastica\Bulk\Action;


/**
 * @package Elastica\Bulk\Action
 * @link http://www.elasticsearch.org/guide/reference/api/bulk/
 */
class UpdateDocument extends IndexDocument
{
    /**
     * @var string
     */
    protected _opType = \Elastica\Bulk\Action::OP_TYPE_UPDATE;

    /**
     * Set the document for this bulk update action.
     * @param \Elastica\Document document
     * @return \Elastica\Bulk\Action\UpdateDocument
     */
    public function setDocument(<\Elastica\Document> document) -> <\Elastica\Document>
    {
        var source, upsert;
        let source = [];

        parent::setDocument(document);

        let source["doc"] = document->getData();

        if document->getDocAsUpsert() {
        	let source["doc_as_upsert"] = true;

        } else {
            if document->hasUpsert() {

                let upsert = document->getUpsert()->getData();

                if !empty upsert {
                    let source["upsert"] = upsert;
                }
            }
        }

        this->setSource(source);

        return this;
    }

    /**
     * @param \Elastica\Script script
     * @return \Elastica\Bulk\Action\AbstractDocument
     */
    public function setScript(<\Elastica\Script>  script) -> <\Elastica\Bulk\Action\AbstractDocument>
    {
        var source, upsert;

        parent::setScript(script);

        let source = script->toArray();

        if script->hasUpsert() {
            let upsert = script->getUpsert()->getData();

            if !empty upsert {
                let source["upsert"] = upsert;
            }
        }

        this->setSource(source);

        return this;
    }

    /**
     * @param \Elastica\Script script
     * @return array
     */
    protected function _getMetadataByScript(<\Elastica\Script> script) -> array
    {
        var params, metadata;
        let params = [
                "index",
                "type",
                "id",
                "version",
                "version_type",
                "routing",
                "percolate",
                "parent",
                "ttl",
                "timestamp"
        ];
        let metadata = script->getOptions(params, true);

        return metadata;
    }
}
