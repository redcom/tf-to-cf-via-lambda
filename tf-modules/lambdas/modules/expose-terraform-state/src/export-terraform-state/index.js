"use strict";

const AWS = require('aws-sdk');
const util = require('util');

const terraformState = async (event, context, callback) => {
  console.log(event, context)

}

module.exports.terraformState = terraformState
