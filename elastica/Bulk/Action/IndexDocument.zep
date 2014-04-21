namespace Elastica\Bulk\Action;


class IndexDocument extends AbstractDocument
{
    /**
     * @var string
     */
    protected _opType = \Elastica\Bulk\Action::OP_TYPE_INDEX;

    /**
     * @param \Elastica\Document document
     * @return \Elastica\Bulk\Action\IndexDocument
     */
    public function setDocument(<\Elastica\Document>  document) -> <\Elastica\Bulk\Action\IndexDocument>
    {
        parent::setDocument(document);
        this->setSource(document->getData());

        return this;
    }

    /**
     * @param \Elastica\Document document
     * @return array
     */
    protected function _getMetadataByDocument(<\Elastica\Document>  document) -> array
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
        let metadata = document->getOptions(params, true);

        return metadata;
    }
}