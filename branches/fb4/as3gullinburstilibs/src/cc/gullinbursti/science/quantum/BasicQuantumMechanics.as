package cc.gullinbursti.science.quantum
{
	import cc.gullinbursti.science.chemistry.BasicChem;
	import cc.gullinbursti.science.physics.BasicPhysics;
	
	public class BasicQuantumMechanics extends BasicPhysics
	{
		
		
		/*
		Values of h 			Units
		6.62606896(33)×10−34 	J·s
		4.13566733(10)×10−15 	eV·s
		6.62606896(33)×10−27 	erg·s
		*/
		public static const PLANCK_CONST:Number = 6.62606896 * Math.pow(10, -34); // J·s
		
		
		/*
		Values of ħ (h/2π) 		Units
		1.054571628(53)×10−34 	J·s
		6.58211899(16)×10−16 	eV·s
		1.054571628(53)×10−27 	erg·s
		*/
		public static const DIRAC_CONST:Number = PLANCK_CONST / (2 * Math.PI);
		
		// R / Nₐ
		public static const BOLTZMANN_CONST:Number = BasicChem.GAS_CONST / BasicChem.AVOGADRO_CONST;
		
		
		
		public function BasicQuantumMechanics()
		{
		}
		
		
		public static function photonEnergyByFreq(freq:Number):Number {
			
			/**
			 * 
			 * E = hν
			 */
			 
			 return (PLANCK_CONST * freq);
		}
		
		
		public static function photonEnergyByWavelen(wavelen:Number):Number {
			
			/**
			 * 
			 *       hc
			 * E = ———————
			 *        λ
			 */
			 
			 
			 return ((PLANCK_CONST * BasicPhysics.LIGHT_VELOCITY) / wavelen);
		}
		
		
		public static function freq(wavelen:Number, spd:Number=BasicPhysics.LIGHT_VELOCITY):Number {
			
			/**
			 * ν = spd / λ
			 * 
			 */
			 
			 return (spd / wavelen);
		}
		
		
		public static function wavelen(freq:Number, spd:Number=BasicPhysics.LIGHT_VELOCITY):Number {
			
			/**
			 * λ = spd / ν
			 * 
			 */
			 
			 return (spd / freq);
		}
		
		
		public static function bodyRadiation():Number {
			// TODO: black body radiation
			 return (0);
		}

	}
}