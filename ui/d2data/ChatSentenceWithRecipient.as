package d2data
{
   public class ChatSentenceWithRecipient extends ChatSentenceWithSource
   {
      
      public function ChatSentenceWithRecipient() {
         super();
      }
      
      public function get receiverName() : String {
         return null;
      }
      
      public function get receiverId() : uint {
         return 0;
      }
   }
}
