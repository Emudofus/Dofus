package com.ankamagames.jerakine.resources.loaders
{
   import com.ankamagames.jerakine.resources.loaders.impl.ParallelRessourceLoader;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.resources.loaders.impl.SingleRessourceLoader;
   
   public class ResourceLoaderFactory extends Object
   {
      
      public function ResourceLoaderFactory() {
         super();
      }
      
      public static function getLoader(param1:uint) : IResourceLoader {
         switch(param1)
         {
            case ResourceLoaderType.PARALLEL_LOADER:
               return new ParallelRessourceLoader(JerakineConstants.MAX_PARALLEL_LOADINGS);
            case ResourceLoaderType.SERIAL_LOADER:
               return new ParallelRessourceLoader(1);
            case ResourceLoaderType.SINGLE_LOADER:
               return new SingleRessourceLoader();
            default:
               throw new ArgumentError("Unknown loader type " + param1 + ".");
         }
      }
   }
}
