package cc.gullinbursti.audio.generate
{
	public class AbstractWave implements ISoundWave
	{
		public function AbstractWave()
		{
		}
		
		public function clone(wave:ISoundWave):ISoundWave {
			
			return (new AbstractWave())
		}
	}
}