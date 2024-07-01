import NodeHttpAdapter from '@pollyjs/adapter-node-http';
import {Polly, setupMocha as setupPolly} from '@pollyjs/core';
import FSPersister from '@pollyjs/persister-fs';
import {MODES} from '@pollyjs/utils';

// @ts-expect-error This should work, is the adapter for pollyjs
Polly.register(NodeHttpAdapter);
// @ts-expect-error This should work, is the adapter for pollyjs
Polly.register(FSPersister);

setupPolly({
	recordIfMissing: true,
	mode: MODES.REPLAY,
	adapters: ['node-http'],
	persister: 'fs',
	persisterOptions: {
		fs: {
			recordingsDir: 'test/recordings'
		}
	}
});
