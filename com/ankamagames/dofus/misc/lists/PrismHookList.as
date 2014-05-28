package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class PrismHookList extends Object
   {
      
      public function PrismHookList() {
         super();
      }
      
      public static const PrismsList:Hook;
      
      public static const PrismsListUpdate:Hook;
      
      public static const KohStarting:Hook;
      
      public static const KohState:Hook;
      
      public static const PrismFightUpdate:Hook;
      
      public static const PrismAttacked:Hook;
      
      public static const PrismInFightAdded:Hook;
      
      public static const PrismInFightRemoved:Hook;
      
      public static const PrismsInFightList:Hook;
      
      public static const PvpAvaStateChange:Hook;
   }
}
