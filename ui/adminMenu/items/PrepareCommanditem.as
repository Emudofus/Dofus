package adminMenu.items
{
   public class PrepareCommanditem extends SendCommandItem
   {
      
      public function PrepareCommanditem(cmd:String, delay:int = 0, repeat:int = 1) {
         super(cmd,delay,repeat);
      }
      
      override public function getcallbackArgs(replaceParam:Object) : Array {
         return [replace(command,replaceParam),false,true];
      }
   }
}
