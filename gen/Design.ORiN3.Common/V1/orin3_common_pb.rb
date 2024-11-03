# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Design.ORiN3.Common/V1/orin3_common.proto

require 'google/protobuf'


descriptor_data = "\n)Design.ORiN3.Common/V1/orin3_common.proto\x12\x13\x44\x65sign.ORiN3.Common*\xec\x16\n\nResultCode\x12\r\n\tSUCCEEDED\x10\x00\x12\x10\n\x08\x43\x41NCELED\x10\xfe\xff\xff\xff\x01\x12\x15\n\rDEFAULT_ERROR\x10\xff\xff\xff\xff\x01\x12*\n\"INCONSISTENCIES_IN_OBJECT_DATABASE\x10\x81\x80\x80\x80\x01\x12 \n\x18O_RI_N3_OBJECT_NOT_FOUND\x10\x80\x82\x80\x80\x01\x12\x1e\n\x16O_RI_N3_OBJECT_DELETED\x10\x81\x82\x80\x80\x01\x12\x18\n\x10NOT_A_CONTROLLER\x10\x82\x82\x80\x80\x01\x12\x16\n\x0eNOT_A_VARIABLE\x10\x83\x82\x80\x80\x01\x12\x13\n\x0bNOT_A_EVENT\x10\x84\x82\x80\x80\x01\x12\x12\n\nNOT_A_FILE\x10\x85\x82\x80\x80\x01\x12\x11\n\tNOT_A_JOB\x10\x86\x82\x80\x80\x01\x12\x14\n\x0cNOT_A_MODULE\x10\x87\x82\x80\x80\x01\x12\x14\n\x0cNOT_A_STREAM\x10\x88\x82\x80\x80\x01\x12 \n\x18NOT_A_CONTROLLER_CREATOR\x10\x80\x84\x80\x80\x01\x12\x18\n\x10NOT_A_EXECUTABLE\x10\x81\x84\x80\x80\x01\x12\x14\n\x0cNOT_A_PARENT\x10\x82\x84\x80\x80\x01\x12\x1d\n\x15NOT_A_RESOURCE_OPENER\x10\x83\x84\x80\x80\x01\x12\x13\n\x0bNOT_A_CHILD\x10\x84\x84\x80\x80\x01\x12\x1b\n\x13NOT_A_CHILD_CREATOR\x10\x85\x84\x80\x80\x01\x12\x1f\n\x17NOT_A_SETTABLE_VARIABLE\x10\x86\x84\x80\x80\x01\x12\x1e\n\x16NOT_A_SUPPORTED_DEVICE\x10\x87\x84\x80\x80\x01\x12\x1d\n\x15NOT_A_SETTABLE_DEVICE\x10\x88\x84\x80\x80\x01\x12\x1b\n\x13\x46\x41ILED_TO_GET_VALUE\x10\x80\x86\x80\x80\x01\x12\x1b\n\x13\x46\x41ILED_TO_SET_VALUE\x10\x81\x86\x80\x80\x01\x12\x1b\n\x13MISMATCH_VALUE_TYPE\x10\x82\x86\x80\x80\x01\x12\x1e\n\x16METHOD_NOT_IMPLEMENTED\x10\x83\x86\x80\x80\x01\x12+\n#CAN_NOT_CREATE_VARIABLE_FROM_MODULE\x10\x80\x88\x80\x80\x01\x12(\n CAN_NOT_CREATE_EVENT_FROM_MODULE\x10\x81\x88\x80\x80\x01\x12)\n!CAN_NOT_CREATE_STREAM_FROM_MODULE\x10\x82\x88\x80\x80\x01\x12\'\n\x1f\x43\x41N_NOT_CREATE_FILE_FROM_MODULE\x10\x83\x88\x80\x80\x01\x12&\n\x1e\x43\x41N_NOT_CREATE_JOB_FROM_MODULE\x10\x84\x88\x80\x80\x01\x12)\n!CAN_NOT_CREATE_MODULE_FROM_MODULE\x10\x85\x88\x80\x80\x01\x12\"\n\x1a\x43\x41N_NOT_CREATE_MORE_MODULE\x10\x86\x88\x80\x80\x01\x12\x1f\n\x17\x43\x41N_NOT_CREATE_VARIABLE\x10\x87\x88\x80\x80\x01\x12\x1c\n\x14\x43\x41N_NOT_CREATE_EVENT\x10\x88\x88\x80\x80\x01\x12\x1d\n\x15\x43\x41N_NOT_CREATE_STREAM\x10\x89\x88\x80\x80\x01\x12\x1b\n\x13\x43\x41N_NOT_CREATE_FILE\x10\x8a\x88\x80\x80\x01\x12\x1a\n\x12\x43\x41N_NOT_CREATE_JOB\x10\x8b\x88\x80\x80\x01\x12\x1d\n\x15\x43\x41N_NOT_CREATE_MODULE\x10\x8c\x88\x80\x80\x01\x12\x19\n\x11\x43OMMAND_NOT_FOUND\x10\x80\x8a\x80\x80\x01\x12 \n\x18\x43OMMAND_EXECUTION_FAILED\x10\x81\x8a\x80\x80\x01\x12\x1e\n\x16JSON_ELEMENT_NOT_FOUND\x10\x80\x8c\x80\x80\x01\x12\x1a\n\x12JSON_INVALID_VALUE\x10\x81\x8c\x80\x80\x01\x12 \n\x18JSON_INVALID_VALUE_RANGE\x10\x82\x8c\x80\x80\x01\x12\x1b\n\x13JSON_INVALID_FORMAT\x10\x83\x8c\x80\x80\x01\x12\x1a\n\x12JSON_UNKNOWN_VALUE\x10\x84\x8c\x80\x80\x01\x12\x1c\n\x14JSON_KEY_DUPLICATION\x10\x85\x8c\x80\x80\x01\x12\"\n\x1aJSON_INVALID_OPTION_FORMAT\x10\x86\x8c\x80\x80\x01\x12\x17\n\x0fINVALID_VERSION\x10\x80\x8e\x80\x80\x01\x12\x17\n\x0fUNMATCH_VERSION\x10\x81\x8e\x80\x80\x01\x12$\n\x1cPROVIDER_VERSION_NOT_DEFINED\x10\x82\x8e\x80\x80\x01\x12\x11\n\tRPC_ERROR\x10\x80\x90\x80\x80\x01\x12\x1d\n\x15\x41RGUMENT_INVALID_NAME\x10\x80\x92\x80\x80\x01\x12\"\n\x1a\x41RGUMENT_INVALID_TYPE_NAME\x10\x81\x92\x80\x80\x01\x12\x1f\n\x17\x41RGUMENT_INVALID_OPTION\x10\x82\x92\x80\x80\x01\x12\x1b\n\x13\x41RGUMENT_NULL_VALUE\x10\x83\x92\x80\x80\x01\x12\x1e\n\x16\x41RGUMENT_INVALID_VALUE\x10\x84\x92\x80\x80\x01\x12\x1d\n\x15\x41RGUMENT_INVALID_TYPE\x10\x85\x92\x80\x80\x01\x12+\n#ARGUMENT_INVALID_NUMBER_OF_ELEMENTS\x10\x86\x92\x80\x80\x01\x12)\n!ARGUMENT_INVALID_TYPE_OF_ELEMENTS\x10\x87\x92\x80\x80\x01\x12\x1a\n\x12\x41RGUMENT_NOT_FOUND\x10\x88\x92\x80\x80\x01\x12\x1c\n\x14\x41RGUMENT_MISSING_KEY\x10\x89\x92\x80\x80\x01\x12 \n\x18\x41RGUMENT_UNNECESSARY_KEY\x10\x8a\x92\x80\x80\x01\x12\'\n\x1f\x41RGUMENT_INVALID_SETVALUE_ARRAY\x10\x8b\x92\x80\x80\x01\x12#\n\x1b\x43OMMUNICATION_FAILED_SERIAL\x10\x80\x94\x80\x80\x01\x12 \n\x18\x43OMMUNICATION_FAILED_TCP\x10\x81\x94\x80\x80\x01\x12 \n\x18\x43OMMUNICATION_FAILED_UDP\x10\x82\x94\x80\x80\x01\x12!\n\x19\x43OMMUNICATION_FAILED_HTTP\x10\x8b\x94\x80\x80\x01\x12#\n\x1b\x43OMMUNICATION_NOT_CONNECTED\x10\x83\x94\x80\x80\x01\x12\x31\n)COMMUNICATION_FAILED_CREATE_CLIENT_SERIAL\x10\x84\x94\x80\x80\x01\x12.\n&COMMUNICATION_FAILED_CREATE_CLIENT_TCP\x10\x85\x94\x80\x80\x01\x12:\n2COMMUNICATION_FAILED_CREATE_CLIENT_TCP_WITH_SRC_IP\x10\x86\x94\x80\x80\x01\x12.\n&COMMUNICATION_FAILED_CREATE_CLIENT_UDP\x10\x87\x94\x80\x80\x01\x12.\n&COMMUNICATION_FAILED_CRETE_CLIENT_HTTP\x10\x8c\x94\x80\x80\x01\x12\'\n\x1f\x43OMMUNICATION_ALREADY_CONNECTED\x10\x88\x94\x80\x80\x01\x12\x1b\n\x13\x43OMMUNICATION_ERROR\x10\x89\x94\x80\x80\x01\x12\x18\n\x10\x46ILE_FAILED_OPEN\x10\x80\x96\x80\x80\x01\x12\x17\n\x0f\x46ILE_NOT_OPENED\x10\x81\x96\x80\x80\x01\x12\x19\n\x11\x46ILE_FAILED_WRITE\x10\x82\x96\x80\x80\x01\x12\x18\n\x10\x46ILE_FAILED_READ\x10\x83\x96\x80\x80\x01\x12\x1b\n\x13\x46ILE_ALREADY_OPENED\x10\x84\x96\x80\x80\x01\x12\x1a\n\x12TAGS_METHOD_FAILED\x10\x80\x98\x80\x80\x01\x12\x18\n\x10TAGS_INVALID_KEY\x10\x81\x98\x80\x80\x01\x12\x1a\n\x12TAGS_KEY_NOT_FOUND\x10\x82\x98\x80\x80\x01\x12\x33\n+TAGS_KEY_DATA_LENGTH_EXCEED_THE_UPPER_LIMIT\x10\x83\x98\x80\x80\x01\x12\"\n\x1aTAGS_UNSUPPORTED_DATA_TYPE\x10\x84\x98\x80\x80\x01\x12/\n\'TAGS_DATA_LENGTH_EXCEED_THE_UPPER_LIMIT\x10\x85\x98\x80\x80\x01\x12\x30\n(TAGS_REGISTRATION_EXCEED_THE_UPPER_LIMIT\x10\x86\x98\x80\x80\x01\x12%\n\x1dPROVIDER_SPECIFIC_RESULT_CODE\x10\x80\x80\xc0\x80\x01\x42R\xaa\x02$Design.ORiN3.Common.V1.AutoGenerated\xea\x02(Design::ORiN3::Common::V1::AutoGeneratedb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Design
  module ORiN3
    module Common
      module V1
        module AutoGenerated
          ResultCode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Design.ORiN3.Common.ResultCode").enummodule
        end
      end
    end
  end
end
