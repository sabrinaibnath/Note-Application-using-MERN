import Note from "../models/Note.js"

export async function  getAllNotes  (_,res) {
   try{
    const notes = await Note.find().sort({createdAt: -1 });
    res.status(200).json(notes);
   }
   catch(error)
   {
     console.error("Error in getAllNotes controller",error);
     res.status(500).json({message:"Internal server error"});
   }
};

export async function getNoteById(req,res){
    try{
     const notesById =await Note.findById(req.params.id);

     if(!notesById){
        return res.status(404).json({message:"id not found"});
     }
     res.status(200).json(notesById);
    }
    catch(error){
        console.error("Error in getAllNotes controller",error);
        res.status(500).json({message:"Internal server error"});
    }
}

export async function createNote(req,res) {
    try{
       const{title,content}=req.body
       const note=new Note({title,content});

       const saveNote = await note.save();
       res.status(201).json({message:"Note created successfully"});
    }
    catch(error)
    {
        console.error("Error in getAllNotes controller",error);
        res.status(500).json(saveNote);
    }
};

export async function updateNote(req,res) {
    try{
       const{title,content}=req.body;
       const updatedNote=await Note.findByIdAndUpdate(
        req.params.id,
        {title,content},
        {
        new:true,
       }
       );

       if(!updatedNote){
         return res.status(404).json({message:"id not found"});
       }
        res.status(200).json({message:"You have updated the note successfully"});

    }
    catch(error){
    console.error("Error in updateNotes controller",error);
     res.status(500).json({message:"Internal server error"});
    }
}

export async function deleteNote(req,res) {
    try{

        const{title,content}=req.body;
        const deleteNote=await Note.findByIdAndDelete(req.params.id,
            {title,content},
            {
                new:true,
            }
            );
            if(!deleteNote){
                return res.status(404).json({message:"id not found"});
            }
            res.status(200).json({message:"You have deleted the note successfully"});
    }
    catch(error)
    {
    console.error("Error in updateNotes controller",error);
     res.status(500).json({message:"Internal server error"});
    }
}
