class UploadedFile {
  final String name;
  final String mime;
  final List<int> data;

  UploadedFile(this.name, this.mime, this.data);
}