import mongoose from "mongoose";

//1st step: create a schema
//2nd step: create a model based on that schema

const noteSchema = new mongoose.Schema({
    title:{
        type:String,
        required: true
    },

    content:{
        type:String,
        required: true
    },

}, 
{timestamps:true} // created At, updated At
);

const Note =mongoose.model("Note", noteSchema);

export default Note;