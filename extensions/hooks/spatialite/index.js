module.exports = async (_, { database, logger }) => {
	// Skip the rest of logic if it's not sqlite3
	if (database.client.config.client !== 'sqlite3') return;

	const pool = database.client.pool;
	const acquire = pool.acquire();

	try {
		const conn = await acquire.promise;
		await conn.loadExtension('/usr/lib/mod_spatialite.so.7');
		logger.info('Spatialite extension loaded successfully.');
		pool.release(conn);
	} catch (err) {
		logger.error('Failed to load Spatialite extension.');
	}
};
