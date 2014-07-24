package d2data
{
   public class ChatSentenceWithSource extends BasicChatSentence
   {
      
      public function ChatSentenceWithSource() {
         super();
      }
      
      public function get senderId() : uint {
         return 0;
      }
      
      public function get senderName() : String {
         return null;
      }
      
      public function get objects() : Object {
         return null;
      }
      
      public function get admin() : Boolean {
         return false;
      }
   }
}
