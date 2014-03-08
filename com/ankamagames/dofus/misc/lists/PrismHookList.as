package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class PrismHookList extends Object
   {
      
      public function PrismHookList() {
         super();
      }
      
      public static const PrismsList:Hook = new Hook("PrismsList",false);
      
      public static const PrismsListUpdate:Hook = new Hook("PrismsListUpdate",false);
      
      public static const KohStarting:Hook = new Hook("KohStarting",false);
      
      public static const KohState:Hook = new Hook("KohState",false);
      
      public static const PrismFightUpdate:Hook = new Hook("PrismFightUpdate",false);
      
      public static const PrismAttacked:Hook = new Hook("PrismAttacked",false);
      
      public static const PrismInFightAdded:Hook = new Hook("PrismInFightAdded",false);
      
      public static const PrismInFightRemoved:Hook = new Hook("PrismInFightRemoved",false);
      
      public static const PrismsInFightList:Hook = new Hook("PrismsInFightList",false);
      
      public static const PvpAvaStateChange:Hook = new Hook("PvpAvaStateChange",false);
   }
}
