const mongoose = require('mongoose');

const Schema = mongoose.Schema;

// Case schema
const caseSchema = new Schema(
  {
    dateTime: {
      type: Date,
      required: true,
    },
    user: {
      type: Schema.Types.ObjectId,
      ref: 'user',
      required: true,
    },
    status: {
      type: String,
      required: true,
      enum: {
        values: [
          'New',
          'Assigned',
          'Partially Assigned',
          'Resolved',
          'Cancelled',
        ],
        message: '{VALUE} is not supported',
      },
    },
    situation: {
      type: String,
      required: true,
    },
    departments: {
      required: true,
      police: {
        assign: {
          type: Boolean,
          required: true,
          default: false,
        },
        status: {
          type: String,
          enum: {
            values: ['New', 'Assigned', 'Resolved', 'Cancelled'],
            message: '{VALUE} is not supported',
          },
        },
        station: {
          type: Schema.Types.ObjectId,
          ref: 'station',
        },
      },
      hospital: {
        assign: {
          type: Boolean,
          required: true,
          default: false,
        },
        status: {
          type: String,
          enum: {
            values: ['New', 'Assigned', 'Resolved', 'Cancelled'],
            message: '{VALUE} is not supported',
          },
        },
        station: {
          type: Schema.Types.ObjectId,
          ref: 'station',
        },
      },
      fireBrigade: {
        assign: {
          type: Boolean,
          required: true,
          default: false,
        },
        status: {
          type: String,
          enum: {
            values: ['New', 'Assigned', 'Resolved', 'Cancelled'],
            message: '{VALUE} is not supported',
          },
        },
        station: {
          type: Schema.Types.ObjectId,
          ref: 'station',
        },
      },
      dmc: {
        assign: {
          type: Boolean,
          required: true,
          default: false,
        },
        status: {
          type: String,
          enum: {
            values: ['New', 'Assigned', 'Resolved', 'Cancelled'],
            message: '{VALUE} is not supported',
          },
        },
        station: {
          type: Schema.Types.ObjectId,
          ref: 'station',
        },
      },
      mwca: {
        assign: {
          type: Boolean,
          required: true,
          default: false,
        },
        status: {
          type: String,
          enum: {
            values: ['New', 'Assigned', 'Resolved', 'Cancelled'],
            message: '{VALUE} is not supported',
          },
        },
        station: {
          type: Schema.Types.ObjectId,
          ref: 'station',
        },
      },
    },
    details: {
      type: String,
    },
    location: {
      type: String,
      required: true,
    },
    images: [{ data: Buffer, contentType: String }],
  },
  { timestamps: true }
);

// Exports the data model of the case
module.exports = mongoose.model('case', caseSchema);
