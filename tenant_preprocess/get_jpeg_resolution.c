#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_HEADER_SIZE 4096

#define SOI_MARKER 0xFFD8
#define SOF0_MARKER 0xFFC0
#define SOF2_MARKER 0xFFC2
#define MARKER_PREFIX 0xFF

// SOF marker layout (example for SOF0)
unsigned char sof_segment[] = {
    0xFF, 0xC0,       // Marker
    0x00, 0x11,       // Length of segment (17 bytes)
    0x08,             // Data precision (8 bits/sample)
    0x00, 0x30,       // Image height (48)
    0x00, 0x40,       // Image width (64)
    0x03,             // Number of components (3: Y, Cb, Cr)
    0x01, 0x11, 0x00, // Component 1 information
    0x02, 0x11, 0x01, // Component 2 information
    0x03, 0x11, 0x01  // Component 3 information
};
/*
int main() {
    unsigned char buffer[2];
    unsigned char segment[5];
    int width, height;

    // Open stdin in binary mode
    freopen(NULL, "rb", stdin);

    // Read the SOI marker (2 bytes)
    fread(buffer, 1, 2, stdin);
    if (buffer[0] != 0xFF || buffer[1] != 0xD8) {
        fprintf(stderr, "Not a valid JPEG file.\n");
        return 1;
    }

    while (1) {
        // Read the marker (2 bytes)
        fread(buffer, 1, 2, stdin);
        if (buffer[0] != 0xFF) {
            fprintf(stderr, "Invalid marker found., b[0]=%x, .\n", buffer[0]);
            return 1;
        }

        // Check if the marker is SOF0 (Start of Frame)
        if (buffer[1] == 0xC0 || buffer[1] == 0xC2) {
            // Read the length of the segment (2 bytes)
            fread(segment, 1, 2, stdin);
            // int length = (segment[0] << 8) + segment[1];

            // Read the next 5 bytes of the segment to get height and width
            fread(segment, 1, 5, stdin);
            height = (segment[1] << 8) + segment[2];
            width = (segment[3] << 8) + segment[4];

            printf("Width: %d, Height: %d\n", width, height);
            return 0;
        } else {
            // Read the length of the segment (2 bytes)
            fread(segment, 1, 2, stdin);
            int length = (segment[0] << 8) + segment[1];

            // Skip the segment
            fseek(stdin, length - 2, SEEK_CUR);
            // fread(segment, 1, length - 2, stdin);
        }
    }

    fprintf(stderr, "SOF0 marker not found.\n");
    return 1;
}
*/


unsigned char* buffer;
size_t buffer_size;
size_t buffer_pos = 0;

// Function to read bytes from the buffer
size_t read_from_buffer(void* ptr, size_t size, size_t count) {
    size_t bytes_to_read = size * count;
    if (buffer_pos + bytes_to_read > buffer_size) {
        bytes_to_read = buffer_size - buffer_pos;
    }
    memcpy(ptr, buffer + buffer_pos, bytes_to_read);
    buffer_pos += bytes_to_read;
    return bytes_to_read;
}

// Function to read a marker from the buffer
int read_marker(unsigned char *marker) {
    return read_from_buffer(marker, 1, 2) == 2 && marker[0] == MARKER_PREFIX;
}

// Function to read the segment length
int read_segment_length() {
    unsigned char length_bytes[2];
    if (read_from_buffer(length_bytes, 1, 2) != 2) {
        return -1;
    }
    return (length_bytes[0] << 8) + length_bytes[1];
}

// Function to skip over a segment
void skip_segment(int length) {
    buffer_pos += length - 2;
}

int process_jpeg(unsigned char* buf, size_t size) {
    buffer = buf;
    buffer_size = size;
    buffer_pos = 0;

    unsigned char marker[2];
    int width, height;

    // Read and verify the SOI marker
    if (!read_marker(marker) || (marker[1] != 0xD8)) {
        fprintf(stderr, "Not a valid JPEG file.\n");
        return 1;
    }

    while (1) {
        // Read the next marker
        if (!read_marker(marker)) {
            fprintf(stderr, "Invalid marker found.\n");
            return 1;
        }

        // Check if the marker is SOF0 or SOF2 (Start of Frame)
        if (marker[1] == 0xC0 || marker[1] == 0xC2) {
            int segment_length = read_segment_length();
            if (segment_length == -1) {
                fprintf(stderr, "Error reading segment length.\n");
                return 1;
            }

            // Read the segment excluding the marker and length (5 bytes offset to height and width)
            unsigned char segment_data[5];
            if (read_from_buffer(segment_data, 1, 5) != 5) {
                fprintf(stderr, "Error reading segment data.\n");
                return 1;
            }

            height = (segment_data[1] << 8) + segment_data[2];
            width = (segment_data[3] << 8) + segment_data[4];

            // printf("Width: %d, Height: %d\n", width, height);
            printf("%d\n", width * height);
            return 0;
        } else {
            int segment_length = read_segment_length();
            if (segment_length == -1) {
                fprintf(stderr, "Error reading segment length.\n");
                return 1;
            }
            skip_segment(segment_length);
        }
    }

    fprintf(stderr, "SOF0 or SOF2 marker not found.\n");
    return 1;
}



int main()
{
    size_t size = 0;
	unsigned char *buf = NULL;

	buf = malloc(MAX_HEADER_SIZE);
	if (!buf) return -1;

	ssize_t bytes_read;
	while ((bytes_read = read(STDIN_FILENO, buf + size, MAX_HEADER_SIZE - size)) > 0) {
		size += bytes_read;
		if (size >= MAX_HEADER_SIZE) break;
	}
	if (size <= 0) return -1;

    int ret = process_jpeg(buf, size);

    return ret;
}