const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { event } = require('firebase-functions/lib/providers/analytics');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
   functions.logger.info("Hello logs!", {structuredData: true});
   response.send("Hello from Firebase!");
   console.log("Hello World");
});

exports.sendDonation = functions.https.onCall(async(data, context) =>{
   
   const uid = data.ngoUID;
   const donorUid = data.donorUID;

   const db = admin.firestore();
   const getDoc = db.collection('users').doc(uid).get().then(doc =>{
      if(!doc.exists){
         console.log("No such Documents");
         return 0;
      }
      else{
         var token = doc.data()['token']
         console.log('Token Recieved: ', token);
         notify(token);
         return 0;
      }
   })

   async function notify(token){
      var message = {
         notification : {
            title: "You got an Donation",
            body: "Click to more actions",
         },
         data : {
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            donorUid : donorUid,
            uid: uid
         },
         token: token,
      }

      await admin.messaging().send(message).then(response=>{
         return console.log('Notification Sent Successfully');
      }).catch(error =>{
         return console.log('Error: ', error);
      })
   }
})