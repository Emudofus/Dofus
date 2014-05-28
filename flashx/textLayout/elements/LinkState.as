package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class LinkState extends Object
   {
      
      public function LinkState() {
         super();
      }
      
      public static const LINK:String = "link";
      
      public static const HOVER:String = "hover";
      
      public static const ACTIVE:String = "active";
      
      tlf_internal  static const SUPPRESSED:String = "supressed";
   }
}
