namespace Elastica\Bulk\Action;

class DeleteDocument extends AbstractDocument
{
    /**
     * @var string
     */
    protected _opType = \Elastica\Bulk\Action::OP_TYPE_DELETE;

    /**
     * @param \Elastica\Document document
     * @return array
     */
    protected function _getMetadataByDocument(<\Elastica\Document> document) -> array
    {
        var params, metadata;
        let params = [
            "index",
            "type",
            "id",
            "version",
            "version_type",
            "routing",
            "parent"
        ];
        let metadata = document->getOptions(params, true);

        return metadata;
    }
}