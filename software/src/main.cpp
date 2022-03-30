// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
#define HI  1
#define LO -1
#define FIXED_POINT_SCALE 16384
// END Code -----------------------------------------------------------------------------------------------------------------------------------------


// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
#include "soc_it_adapter.h"
#include "soc_it_capi.h"
#include "brute_force_matcher_v1_00_a.h"
// END Code -----------------------------------------------------------------------------------------------------------------------------------------

// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
#include <iostream>
using namespace std;
// END Code -----------------------------------------------------------------------------------------------------------------------------------------


// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
typedef struct {
	SocItHandle *matchTable_hndl = NULL;
	SocItHandle *modelData_hndl = NULL;
	SocItHandle *cellData_hndl = NULL;
	SocItHandle *matchTableInfoOutput_hndl = NULL;
	keypoint_t<uint32_t> *modelData_ptr = NULL;
	keypoint_t<uint32_t> *cellData_ptr = NULL;
	keypoint_t<float> *modelDataF_ptr = NULL;
	keypoint_t<float> *cellDataF_ptr = NULL;
	matchTableInfoOutput_t *matchTableInfoOutput_ptr = NULL;
	matchTable_t *matchTableSol_ptr = NULL;
} accel_data_t;

SocItAdapter *m_adapter;
// END Code -----------------------------------------------------------------------------------------------------------------------------------------


void print_devices(int numFound, VendorDevicePair** devices)
{
	printf("SOC_IT to CAPI interface probe found %d Device%s\r\n", numFound, (numFound == 1) ? "" : "s");
	for (int i = 0; i < numFound; i++)
	{
		printf("Port %d\t - Vendor : 0x%04X\t Device : 0x%04X\r\n", devices[i]->PortIdx, devices[i]->Vendor, devices[i]->Device);
	}
}


void createSimData(int numModelKeypoints, int numCellsX, int numCellsY, int keypointsPerCell, accel_data_t &accel_data) {

	// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
	accel_data.modelData_hndl = m_adapter->AllocateMemoryHandle(numModelKeypoints * sizeof(keypoint_t<uint32_t>));
	accel_data.modelData_ptr = (keypoint_t<uint32_t>*)accel_data.modelData_hndl->get_offset();
	keypoint_t<uint32_t> *modelData_ptr = accel_data.modelData_ptr;
	accel_data.modelDataF_ptr = (keypoint_t<float>*)malloc(numModelKeypoints * sizeof(keypoint_t<float>));
	keypoint_t<float> *modelDataF_ptr = accel_data.modelDataF_ptr;
	for (int i = 0; i < numModelKeypoints; i++) {
		modelData_ptr[i].x = 1;				// value is irrelevant for matcher
		modelData_ptr[i].y = 2;				// value is irrelevant for matcher
		modelData_ptr[i].cell_id = 3;		// value is irrelevant for matcher
		modelData_ptr[i].id = i;
		modelData_ptr[i].scale = 4;			// value is irrelevant for matcher
		modelData_ptr[i].laplacian = 5;		// value is irrelevant for matcher

		modelDataF_ptr[i].id = i;

		for (int d = 0; d < DESC_SIZE; d++) {
			float r3 = LO + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / (HI - LO)));
			int32_t temp = (int32_t)floorf(r3 * (FIXED_POINT_SCALE));
			modelData_ptr[i].descriptors[d] = temp;
			modelDataF_ptr[i].descriptors[d] = r3;
		}
	}

	// FILE *fd = fopen("temp.txt", "w");
	// _uint128_t *modelData_ptr = (_uint128_t*)accel_data.modelData_ptr;
	// fprintf(fd, "%016llX%016llX\n", modelData_ptr[0].upper, modelData_ptr[0].lower);
	// for (int d = 1; d < ((DESC_SIZE * 4) / 16); d++) {
	// 	uint64_t temp0 = modelData_ptr[d].lower;
	// 	uint64_t temp1 = modelData_ptr[d].upper;
	// 	fprintf(fd, "%016llX%016llX\n", temp1, temp0);
	// }
	// fclose(fd);
	// END Code -----------------------------------------------------------------------------------------------------------------------------------------


	// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
	int numObsvdKeypoints = keypointsPerCell * numCellsX * numCellsY;
	accel_data.cellData_hndl = m_adapter->AllocateMemoryHandle(numObsvdKeypoints * sizeof(keypoint_t<uint32_t>));
	accel_data.cellData_ptr = (keypoint_t<uint32_t>*)accel_data.cellData_hndl->get_offset();
	keypoint_t<uint32_t> *cellData_ptr = accel_data.cellData_ptr;
	accel_data.cellDataF_ptr = (keypoint_t<float>*)malloc(numObsvdKeypoints * sizeof(keypoint_t<float>));
	keypoint_t<float> *cellDataF_ptr = accel_data.cellDataF_ptr;
	for (int i = 0, u = 0; i < numCellsY; i++) {
		for (int j = 0; j < numCellsX; j++) {
			for (int k = 0; k < keypointsPerCell; k++, u++) {
				cellData_ptr[u].x = 1;
				cellData_ptr[u].y = 2;
				cellData_ptr[u].cell_id = (uint16_t)(i * numCellsX + j);
				cellData_ptr[u].id = i;
				cellData_ptr[u].scale = 3;
				cellData_ptr[u].laplacian = 4;

				cellDataF_ptr[u].id = i;

				for (int d = 0; d < DESC_SIZE; d++) {
					float r3 = LO + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / (HI - LO)));
					int32_t temp = (int32_t)floorf(r3 * (FIXED_POINT_SCALE)); 													
					cellData_ptr[u].descriptors[d] = temp;
					cellDataF_ptr[u].descriptors[d] = r3;
				}
			}
		}
	}
	// END Code -----------------------------------------------------------------------------------------------------------------------------------------


	// BEGIN Code ---------------------------------------------------------------------------------------------------------------------------------------
	float d1;
	float d2;
	float dist;
	accel_data.matchTableSol_ptr = (matchTable_t*)malloc(numObsvdKeypoints * sizeof(matchTable_t));
	matchTable_t *matchTableSol_ptr = accel_data.matchTableSol_ptr;
	for (int i = 0; i < numObsvdKeypoints; i++) {
		d1 = FLT_MAX;
		d2 = FLT_MAX;
		for (int j = 0; j  < numModelKeypoints; j++) {
			dist = 0.0f;
			for (int k = 0; k < DESC_SIZE; k++) {
				dist += ((cellDataF_ptr[i].descriptors[k] - modelDataF_ptr[j].descriptors[k]) * (cellDataF_ptr[i].descriptors[k] - modelDataF_ptr[j].descriptors[k]));
			}	
			dist = sqrtf(dist);
			if (dist < d1) {
				d2 = d1;
				matchTableSol_ptr[i].second_model_id = matchTableSol_ptr[i].first_model_id;
				matchTableSol_ptr[i].second_query_id = matchTableSol_ptr[i].first_query_id;
				matchTableSol_ptr[i].second_score = d2;
				d1 = dist;
				matchTableSol_ptr[i].first_model_id = j;
				matchTableSol_ptr[i].first_query_id = i;
				matchTableSol_ptr[i].first_score = d1;
			} else if(dist < d2) {
				d2 = dist;
				matchTableSol_ptr[i].second_model_id = j;
				matchTableSol_ptr[i].second_query_id = i;
				matchTableSol_ptr[i].second_score = d2;
			}
		}
	}
	// END Code -----------------------------------------------------------------------------------------------------------------------------------------

}


int main(int argc, char **argv) {

	// BEGIN Code --------------------------------------------------------------------------------------------------------------------------------------
	m_adapter = new SocItCapiAdapter();

	if (!m_adapter->Initialize(10084)) {
		delete(m_adapter);
		return 1;
	}

	VendorDevicePair** device_info_result;
	printf("\r\n\r\n");

	printf("--------------------------------------------------------\r\n");
	printf("Performing probe for available SOC_IT devices\r\n");
	printf("--------------------------------------------------------\r\n");

	int numFound = m_adapter->FindDevices(&device_info_result);
	print_devices(numFound, device_info_result);
	printf("--------------------------------------------------------\r\n\r\n");

	brute_force_matcher_v1_00_a	accel_handle("BruteForceMatcher", 0, 0, device_info_result[0]->PortIdx, m_adapter);
	// END Code ----------------------------------------------------------------------------------------------------------------------------------------


	// BEGIN Code --------------------------------------------------------------------------------------------------------------------------------------
	int numModelKeypoints = 25;
	int keypointsPerCell = 6;
	int numCellsX = 1;
	int numCellsY = 1;
	int numObsvdKeypoints = numCellsX * numCellsY * keypointsPerCell;
	accel_data_t accel_data;
	createSimData(numModelKeypoints, numCellsX, numCellsY, keypointsPerCell, accel_data);
	// END Code ----------------------------------------------------------------------------------------------------------------------------------------


	// BEGIN Code --------------------------------------------------------------------------------------------------------------------------------------
	accel_handle.Process(
		accel_data.modelData_hndl->get_offset(),
		accel_data.modelData_hndl->get_size(),
		accel_data.cellData_hndl->get_offset(),
		accel_data.cellData_hndl->get_size(),
		&(accel_data.matchTable_hndl),
		&(accel_data.matchTableInfoOutput_hndl),
		numCellsX,
		numCellsY,
		true
	);
	// END Code ----------------------------------------------------------------------------------------------------------------------------------------


	// BEGIN Code --------------------------------------------------------------------------------------------------------------------------------------
	matchTable_t *matchTableSol_ptr = accel_data.matchTableSol_ptr;
	matchTable_t *matchTableOut_ptr = (matchTable_t*)accel_data.matchTable_hndl->get_offset();

	FILE *fd = fopen("matchSol.txt", "w");
	for (int i = 0; i < numObsvdKeypoints; i++) {
		// fprintf(fd,
		// 	"Observed ID %d: Best Model: %d Best Distance %f Observed ID %d: 2nd Best Model: %d 2nd Best Distance: %f\n",
		// 	matchTableSol_ptr[i].first_query_id,
		// 	matchTableSol_ptr[i].first_model_id,
		// 	matchTableSol_ptr[i].first_score,
		// 	matchTableSol_ptr[i].second_query_id,
		// 	matchTableSol_ptr[i].second_model_id,
		// 	matchTableSol_ptr[i].second_score);
		fprintf(fd,
			"Observed ID %d: Best Model: %d Observed ID %d: 2nd Best Model: %d\n",
			matchTableSol_ptr[i].first_query_id,
			matchTableSol_ptr[i].first_model_id,
			matchTableSol_ptr[i].second_query_id,
			matchTableSol_ptr[i].second_model_id);
	}
	fclose(fd);

	fd = fopen("matchOut.txt", "w");
	for (int i = 0; i < numObsvdKeypoints; i++) {
		// fprintf(fd,
		// 	"Observed ID %d: Best Model: %d Best Distance %f Observed ID %d: 2nd Best Model: %d 2nd Best Distance: %f\n",
		// 	matchTableOut_ptr[i].first_query_id,
		// 	matchTableOut_ptr[i].first_model_id,
		// 	matchTableOut_ptr[i].first_score,
		// 	matchTableOut_ptr[i].second_query_id,
		// 	matchTableOut_ptr[i].second_model_id,
		// 	matchTableOut_ptr[i].second_score);
		fprintf(fd,
			"Observed ID %d: Best Model: %d Observed ID %d: 2nd Best Model: %d\n",
			matchTableOut_ptr[i].first_query_id,
			matchTableOut_ptr[i].first_model_id,
			matchTableOut_ptr[i].second_query_id,
			matchTableOut_ptr[i].second_model_id);
	}
	fclose(fd);


	for (int i = 0; i < numObsvdKeypoints; i++) {
		if (
			matchTableSol_ptr[i].first_model_id != matchTableOut_ptr[i].first_model_id
				|| matchTableSol_ptr[i].first_query_id != matchTableOut_ptr[i].first_query_id
		) {
			cout << "Results were bad" << endl;
			while (true);
			return 1;
		} else if (
			(matchTableSol_ptr[i].second_model_id != matchTableOut_ptr[i].second_model_id
				|| matchTableSol_ptr[i].second_query_id != matchTableOut_ptr[i].second_query_id)
				&& numModelKeypoints > 1
		) {
			cout << "Results were bad" << endl;
			while (true);
			return 1;
		}
	}
	cout << "Results were good" << endl;
	// END Code ----------------------------------------------------------------------------------------------------------------------------------------

	while (true);
	return 0;
}