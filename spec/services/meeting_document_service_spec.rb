require 'rails_helper'

RSpec.describe MeetingDocumentService do
  describe 'upload document' do
    it 'creates document and connect with files' do
      meeting = create(:meeting, year: '16/17', title: 'S15')
      meeting.file_sv = test_file
      meeting.file_en = test_file2
      meeting.document_kind = :agenda

      expect do
        MeetingDocumentService.upload_document(meeting)
      end.to change(MeetingDocument, :count).by(1)
    end

    it 'creates a document and defaults to file' do
      meeting = create(:meeting, year: '16/17', title: 'S15')
      meeting.file_sv = test_file
      meeting.file_sv_url = "a_faulty_url/"
      meeting.document_kind = :agenda

      expect do
        MeetingDocumentService.upload_document(meeting)
      end.to change(MeetingDocument, :count).by(1)

      mdoc = MeetingDocument.last
      expect(mdoc.file_sv_identifier).to eq("file.pdf")
    end

    it 'does not create meeting document with faulty url' do
      meeting = create(:meeting, year: '16/17', title: 'S15')
      meeting.file_sv_url = "localhost:3000/an_url"
      meeting.file_en = test_file2
      meeting.document_kind = :agenda
      result = false

      expect do
        result = MeetingDocumentService.upload_document(meeting)
      end.to change(MeetingDocument, :count).by(0)

      expect(result).to be_falsey
      expect(meeting.errors[:document_kind]).to_not be_nil
    end
  end

  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
  end

  def test_file2
    Rack::Test::UploadedFile.new(File.open('spec/support/file2.pdf'))
  end
end
