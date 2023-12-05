const createImageCollectionFrom = (baseUrlWithDocumentPath, imageDetails) => {
  const imagesCollection = imageDetails.map(image => {
    const isPdf = image.FileType.toUpperCase() === "PDF" ? true : false;
    return {
      id: image.ContentDocumentId,
      isPdf,
      src: `${baseUrlWithDocumentPath}${image.ContentDocumentId}`,
      title: image.Title,
      titleWithFileName: image.PathOnClient
    };
  });
  return imagesCollection;
};

export { createImageCollectionFrom };
