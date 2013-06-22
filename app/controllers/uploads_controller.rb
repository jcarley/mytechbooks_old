module Aws
  class UploadsController < ApplicationController
    respond_to :json

    before_filter :authenticate_user!

    def init
      hash = S3UploadRequest.new(:type => :init, :params => params).to_h
      respond_with hash
    end

    def chunk
      hash = S3UploadRequest.new(:type => :part, :params => params).to_h
      respond_with hash
    end

    def end_signature
      hash = S3UploadRequest.new(:type => :complete, :params => params).to_h
      respond_with hash
    end

    def list
      hash = S3UploadRequest.new(:type => :list, :params => params).to_h
      respond_with hash
    end

    def delete
      hash = S3UploadRequest.new(:type => :delete, :params => params).to_h
      respond_with hash
    end

    def all
      list     = S3UploadRequest.new(:type => :list, :params => params)
      complete = S3UploadRequest.new(:type => :complete, :params => params)

      chunk_signatures = {}
      params[:num_chunks].to_i.times do |chunk|
        chunk_number = chunk + 1
        params[:chunk] = chunk_number
        request = S3UploadRequest.new(:type => :part, :params => params)
        chunk_signatures[chunk_number] = [request.signature, request.date]
      end

      hash = {
        :list_signature   => [list.signature, list.date],
        :end_signature    => [complete.signature, complete.date],
        :chunk_signatures => chunk_signatures
      }
      respond_with hash
    end

  end
end
