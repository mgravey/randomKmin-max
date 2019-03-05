#include "mex.h"
#include "fKst.hpp"

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {

	if ((nrhs <= 2) && (nrhs > 3)){
		mexErrMsgIdAndTxt("MATLAB:randomkmin:invalidNumInputs", "2 or 3 inputs required the array and k.");
	}
	if (!mxIsScalar(prhs[1])) {
		mexErrMsgIdAndTxt("MATLAB:randomkmin:inputNotScalar",
			"Second imput must be a scalar");
	}

	unsigned seed=std::chrono::high_resolution_clock::now().time_since_epoch().count();
	if(nrhs>2) seed=unsigned(ceil(mxGetScalar(prhs[2])));

	size_t sizeArray=mxGetNumberOfElements(prhs[0]);
	int k=int(ceil(mxGetScalar(prhs[1])));

	mxClassID dataType=mxGetClassID(prhs[0]);
	void* ptrData = mxGetPr(prhs[0]);

/* Create matrix for the return argument. */
	mwSize sizeKArray=k;
	plhs[0] = mxCreateNumericArray(1, (const mwSize *)&sizeKArray, dataType, mxREAL);
	plhs[1] = mxCreateNumericArray(1, (const mwSize *)&sizeKArray, mxUINT32_CLASS, mxREAL);

	void* ptrResult = mxGetPr(plhs[0]);
	uint32_t* ptrPosition =(uint32_t*) mxGetPr(plhs[1]);

	std::mt19937 generator;
	generator.seed(seed);
	std::uniform_real_distribution<float> distribution(0.0,1.0);

	auto rng = std::bind(distribution, std::ref(generator));

	switch(dataType) {
		case mxSINGLE_CLASS:
			fKst::findKSmallest((float*) ptrData, sizeArray, k, (float*) ptrResult, (unsigned int*)ptrPosition, rng);
			break;
		case mxDOUBLE_CLASS:
			fKst::findKSmallest((double*) ptrData, sizeArray, k, (double*) ptrResult, (unsigned int*)ptrPosition, rng);
			break;

		// you can have any number of case statements.
		default : //Optional
		mexErrMsgIdAndTxt("MATLAB:randomkmin:invalidNumInputs", "dataType not supported");
	}

	for (int i = 0; i < k; ++i)
	{
		ptrPosition[i]++;
	}	

}
